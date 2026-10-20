using CursosCertificadosApp.Data;
using CursosCertificadosApp.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// 1. Configuración de Puerto Dinámico para Entorno Cloud / Contenedores (Railway, Render, Fly.io, etc.)
var envPort = Environment.GetEnvironmentVariable("PORT");
if (!string.IsNullOrEmpty(envPort))
{
    builder.WebHost.UseUrls($"http://0.0.0.0:{envPort}");
}

// 2. Configuración de Proveedor de Base de Datos (PostgreSQL / Supabase por defecto)
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") 
    ?? builder.Configuration.GetConnectionString("PostgresConnection");
var dbProvider = builder.Configuration.GetValue<string>("DatabaseProvider") ?? "PostgreSql";

builder.Services.AddDbContext<AppDbContext>(options =>
{
    var isPostgres = dbProvider.Equals("PostgreSql", StringComparison.OrdinalIgnoreCase)
        || (!string.IsNullOrEmpty(connectionString) && connectionString.Contains("Host=", StringComparison.OrdinalIgnoreCase));

    if (isPostgres)
    {
        options.UseNpgsql(connectionString, npgsqlOptions =>
        {
            npgsqlOptions.EnableRetryOnFailure(
                maxRetryCount: 5,
                maxRetryDelay: TimeSpan.FromSeconds(10),
                errorCodesToAdd: null);
            npgsqlOptions.CommandTimeout(120);
        });
    }
    else
    {
        options.UseSqlite(connectionString ?? "Data Source=CursosGlobalesJP.db");
    }
});

// 3. Configuración de Forwarded Headers (Cloudflare, Railway, Nginx, Proxies Inversos)
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

// 6. Inicialización, Migración Automática y Creación/Seeding de Base de Datos en la Nube
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var logger = services.GetRequiredService<ILogger<Program>>();
    var dbContext = services.GetRequiredService<AppDbContext>();

    try
    {
        logger.LogInformation("Verificando conexión y esquema de base de datos en la nube...");

        if (dbContext.Database.IsRelational())
        {
            var pendingMigrations = await dbContext.Database.GetPendingMigrationsAsync();
            if (pendingMigrations.Any())
            {
                logger.LogInformation("Aplicando migraciones pendientes de base de datos...");
                await dbContext.Database.MigrateAsync();
            }
            else
            {
                logger.LogInformation("Asegurando tablas y esquema relacional...");
                await dbContext.Database.EnsureCreatedAsync();
            }
        }
        else
        {
            await dbContext.Database.EnsureCreatedAsync();
        }

        logger.LogInformation("Ejecutando Seed Data del catálogo de cursos y Administrador Master...");
        await DbSeeder.SeedAsync(dbContext);
        logger.LogInformation("Base de datos y catálogo inicializados exitosamente.");
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Aviso durante la inicialización de base de datos: {Message}. Ejecutando inicialización de respaldo...", ex.Message);
        try
        {
            await dbContext.Database.EnsureCreatedAsync();
            await DbSeeder.SeedAsync(dbContext);
            logger.LogInformation("Base de datos asegurada mediante inicialización directa.");
        }
        catch (Exception ex2)
        {
            logger.LogError(ex2, "Error crítico al inicializar la base de datos: {Message}", ex2.Message);
        }
    }
}

// 7. Pipeline HTTP y Forwarded Headers
app.UseForwardedHeaders();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
