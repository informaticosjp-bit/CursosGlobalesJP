using CursosCertificadosApp.Data;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;

var builder = WebApplication.CreateBuilder(args);

// 1. Configuración de Puerto Dinámico para Entornos Cloud / Contenedores (Render, Railway, Docker)
var envPort = Environment.GetEnvironmentVariable("PORT") ?? "8080";
builder.WebHost.UseUrls($"http://0.0.0.0:{envPort}");

// 2. Resolución y normalización de la Cadena de Conexión (PostgreSQL / Supabase)
var connectionString = ResolveConnectionString(builder.Configuration);
var dbProvider = builder.Configuration.GetValue<string>("DatabaseProvider") ?? "PostgreSql";

builder.Services.AddDbContext<AppDbContext>(options =>
{
    var isPostgres = dbProvider.Equals("PostgreSql", StringComparison.OrdinalIgnoreCase)
        || (!string.IsNullOrEmpty(connectionString) && (
            connectionString.Contains("Host=", StringComparison.OrdinalIgnoreCase) ||
            connectionString.Contains("Server=", StringComparison.OrdinalIgnoreCase)));

    if (isPostgres)
    {
        options.UseNpgsql(connectionString, npgsqlOptions =>
        {
            npgsqlOptions.EnableRetryOnFailure(
                maxRetryCount: 3,
                maxRetryDelay: TimeSpan.FromSeconds(5),
                errorCodesToAdd: null);
            npgsqlOptions.CommandTimeout(30);
        });
    }
    else
    {
        options.UseSqlite(connectionString ?? "Data Source=CursosGlobalesJP.db");
    }
});

// 3. Configuración de Forwarded Headers (Cloudflare, Render, Railway, Nginx)
builder.Services.Configure<ForwardedHeadersOptions>(options =>
{
    options.ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto | ForwardedHeaders.XForwardedHost;
    options.KnownIPNetworks.Clear();
    options.KnownProxies.Clear();
});

// 4. Autenticación por Cookies segura y ligera
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/Account/Login";
        options.LogoutPath = "/Account/Logout";
        options.AccessDeniedPath = "/Account/AccessDenied";
        options.ExpireTimeSpan = TimeSpan.FromDays(30);
        options.Cookie.SameSite = SameSiteMode.Lax;
        options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
    });

// 5. Servicios de Negocio de Cursos Globales JP
builder.Services.AddHttpClient();
builder.Services.AddMemoryCache();
builder.Services.AddSingleton<IBcvRateService, BcvRateService>();
builder.Services.AddScoped<ICertificateService, CertificateService>();
builder.Services.AddScoped<IProgressService, ProgressService>();
builder.Services.AddScoped<IPaymentService, PaymentService>();
builder.Services.AddScoped<IDatabaseBackupService, DatabaseBackupService>();
builder.Services.AddScoped<ISiteSettingService, SiteSettingService>();
builder.Services.AddScoped<ICvService, CvService>();

builder.Services.AddControllersWithViews();

var app = builder.Build();

// 6. Inicialización Segura y No Bloqueante de Base de Datos en la Nube
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var logger = services.GetRequiredService<ILogger<Program>>();
    var dbContext = services.GetRequiredService<AppDbContext>();

    logger.LogInformation("[CONFIG DB] Cadena activa configurada: {Conn}", MaskConnectionString(connectionString));

    try
    {
        logger.LogInformation("[DB] Verificando conectividad con Supabase PostgreSQL...");

        using var cts = new CancellationTokenSource(TimeSpan.FromSeconds(15));
        var canConnect = await dbContext.Database.CanConnectAsync(cts.Token);

        if (canConnect)
        {
            logger.LogInformation("[DB SUCCESS] Conexión establecida exitosamente con Supabase PostgreSQL.");

            bool catalogExists = false;
            try
            {
                catalogExists = await dbContext.Courses.AnyAsync(cts.Token);
            }
            catch
            {
                catalogExists = false;
            }

            if (catalogExists)
            {
                logger.LogInformation("[DB INFO] El catálogo de cursos y tablas ya existen en Supabase. Omitiendo creación repetitiva.");
            }
            else
            {
                logger.LogInformation("[DB SEED] Catálogo vacío detectado. Creando tablas e insertando datos iniciales...");
                await dbContext.Database.EnsureCreatedAsync(cts.Token);
                await DbSeeder.SeedAsync(dbContext);
                logger.LogInformation("[DB SEED] Catálogo y Administrador Master creados exitosamente.");
            }
        }
        else
        {
            logger.LogWarning("[DB WARNING] CanConnectAsync devolvió false. El servidor continuará arrancando para no congelar Render.");
        }
    }
    catch (OperationCanceledException)
    {
        logger.LogError("[DB TIMEOUT] La verificación de base de datos superó los 15 segundos al arrancar. El servidor web iniciará normalmente.");
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "[DB ERROR] Fallo durante la verificación de base de datos: {Message}. El servidor web iniciará para permitir diagnóstico.", ex.Message);
    }
}

// 7. Pipeline HTTP y Forwarded Headers
app.UseForwardedHeaders();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseStaticFiles();
app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();

// -----------------------------------------------------------------------------------------
// Métodos Auxiliares para Conectividad Cloud y Parseo de Cadenas de Conexión
// -----------------------------------------------------------------------------------------
static string ResolveConnectionString(IConfiguration configuration)
{
    // 1. Variable de entorno directa DATABASE_URL (Render, Railway, Fly.io, Heroku)
    var databaseUrl = Environment.GetEnvironmentVariable("DATABASE_URL");
    if (!string.IsNullOrWhiteSpace(databaseUrl))
    {
        return ParsePostgresUrl(databaseUrl);
    }

    // 2. Variable de entorno o appsettings ConnectionStrings:DefaultConnection
    var defaultConn = Environment.GetEnvironmentVariable("ConnectionStrings__DefaultConnection")
        ?? configuration.GetConnectionString("DefaultConnection");

    if (!string.IsNullOrWhiteSpace(defaultConn))
    {
        return ParsePostgresUrl(defaultConn);
    }

    // 3. Fallback a PostgresConnection
    var postgresConn = Environment.GetEnvironmentVariable("ConnectionStrings__PostgresConnection")
        ?? configuration.GetConnectionString("PostgresConnection");

    if (!string.IsNullOrWhiteSpace(postgresConn))
    {
        return ParsePostgresUrl(postgresConn);
    }

    // 4. Fallback local SQLite
    return "Data Source=CursosGlobalesJP.db";
}

static string ParsePostgresUrl(string input)
{
    if (string.IsNullOrWhiteSpace(input)) return input;

    // Si ya viene en formato de parámetros Npgsql (Host=...;Database=...)
    if (input.Contains("Host=", StringComparison.OrdinalIgnoreCase) || input.Contains("Server=", StringComparison.OrdinalIgnoreCase))
    {
        return input;
    }

    // Si viene en formato URL (postgres:// o postgresql://)
    if (input.StartsWith("postgres://", StringComparison.OrdinalIgnoreCase) ||
        input.StartsWith("postgresql://", StringComparison.OrdinalIgnoreCase))
    {
        try
        {
            var uri = new Uri(input);
            var userInfo = uri.UserInfo.Split(':');
            var user = Uri.UnescapeDataString(userInfo[0]);
            var password = userInfo.Length > 1 ? Uri.UnescapeDataString(userInfo[1]) : "";
            var port = uri.Port > 0 ? uri.Port : 5432;
            var database = uri.AbsolutePath.TrimStart('/');

            return $"Host={uri.Host};Port={port};Database={database};Username={user};Password={password};Ssl Mode=Require;Trust Server Certificate=true;";
        }
        catch
        {
            return input;
        }
    }

    return input;
}

static string MaskConnectionString(string connectionString)
{
    if (string.IsNullOrWhiteSpace(connectionString)) return "(vacía)";
    return Regex.Replace(
        connectionString,
        @"(Password|pwd)\s*=\s*[^;]+",
        "$1=********",
        RegexOptions.IgnoreCase);
}
