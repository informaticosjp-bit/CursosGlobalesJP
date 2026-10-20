using System.Globalization;
using System.Net.Http.Json;
using System.Text.Json.Serialization;
using System.Text.RegularExpressions;

namespace CursosCertificadosApp.Services
{
    public class BcvRateResult
    {
        public decimal UsdRate { get; set; }
        public string ValueDate { get; set; } = string.Empty;
        public DateTime LastCheckedAt { get; set; } = DateTime.UtcNow;
        public bool IsLiveFromBcv { get; set; } = true;
        public string Source { get; set; } = "Banco Central de Venezuela (BCV Oficial)";

        public string FormattedRate => UsdRate.ToString("N2", new CultureInfo("es-VE"));

        public decimal CalculateBsForUsd(decimal usdAmount = 1.00m)
        {
            return Math.Round(usdAmount * UsdRate, 2);
        }

        public string GetFormattedTotalBs(decimal usdAmount = 1.00m)
        {
            return CalculateBsForUsd(usdAmount).ToString("N2", new CultureInfo("es-VE"));
        }
    }

    public interface IBcvRateService
    {
        Task<BcvRateResult> GetCurrentRateAsync(bool forceRefresh = false);
        void SetManualRate(decimal rate, string reason);
        void ClearManualOverride();
    }

    public class BcvRateService : IBcvRateService
    {
        private static BcvRateResult? _cachedResult;
        private static DateTime _cacheExpiration = DateTime.MinValue;
        private static decimal? _manualOverrideRate;
        private static readonly object _lock = new();

        private readonly IHttpClientFactory _httpClientFactory;
        private readonly ILogger<BcvRateService> _logger;

        public BcvRateService(IHttpClientFactory httpClientFactory, ILogger<BcvRateService> logger)
        {
            _httpClientFactory = httpClientFactory;
            _logger = logger;
        }

        public async Task<BcvRateResult> GetCurrentRateAsync(bool forceRefresh = false)
        {
            lock (_lock)
            {
                if (_manualOverrideRate.HasValue && !forceRefresh)
                {
                    return new BcvRateResult
                    {
                        UsdRate = _manualOverrideRate.Value,
                        ValueDate = DateTime.Now.ToString("dd/MM/yyyy"),
                        LastCheckedAt = DateTime.UtcNow,
                        IsLiveFromBcv = false,
                        Source = "Tasa fijada manualmente por Administrador"
                    };
                }

                if (!forceRefresh && _cachedResult != null && DateTime.UtcNow < _cacheExpiration)
                {
                    return _cachedResult;
                }
            }

            // Intento 1: Scraping Directo a www.bcv.org.ve
            try
            {
                var directBcvRate = await FetchDirectFromBcvAsync();
                if (directBcvRate != null && directBcvRate.UsdRate > 0)
                {
                    lock (_lock)
                    {
                        _cachedResult = directBcvRate;
                        _cacheExpiration = DateTime.UtcNow.AddMinutes(30);
                    }
                    return directBcvRate;
                }
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Fallo al consultar tasa directamente en www.bcv.org.ve. Intentando respaldo oficial...");
            }

            // Intento 2: API Respaldo con datos oficiales del BCV
            try
            {
                var backupRate = await FetchFromBackupApiAsync();
                if (backupRate != null && backupRate.UsdRate > 0)
                {
                    lock (_lock)
                    {
                        _cachedResult = backupRate;
                        _cacheExpiration = DateTime.UtcNow.AddMinutes(30);
                    }
                    return backupRate;
                }
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Fallo al consultar API de respaldo de BCV.");
            }

            // Fallback seguro en memoria o valor referencial reciente
            lock (_lock)
            {
                if (_cachedResult != null) return _cachedResult;

                _cachedResult = new BcvRateResult
                {
                    UsdRate = 881.07m,
                    ValueDate = DateTime.Now.ToString("dd/MM/yyyy"),
                    LastCheckedAt = DateTime.UtcNow,
                    IsLiveFromBcv = false,
                    Source = "Tasa referencial de contingencia BCV"
                };
                return _cachedResult;
            }
        }

        public void SetManualRate(decimal rate, string reason)
        {
            lock (_lock)
            {
                _manualOverrideRate = rate;
                _cachedResult = new BcvRateResult
                {
                    UsdRate = rate,
                    ValueDate = DateTime.Now.ToString("dd/MM/yyyy"),
                    LastCheckedAt = DateTime.UtcNow,
                    IsLiveFromBcv = false,
                    Source = $"Ajuste Manual: {reason}"
                };
            }
        }

        public void ClearManualOverride()
        {
            lock (_lock)
            {
                _manualOverrideRate = null;
                _cacheExpiration = DateTime.MinValue;
            }
        }

        private async Task<BcvRateResult?> FetchDirectFromBcvAsync()
        {
            var handler = new HttpClientHandler
            {
                ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
            };

            using var client = new HttpClient(handler)
            {
                Timeout = TimeSpan.FromSeconds(12)
            };

            client.DefaultRequestHeaders.UserAgent.ParseAdd("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36");
            client.DefaultRequestHeaders.Accept.ParseAdd("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");

            var html = await client.GetStringAsync("https://www.bcv.org.ve/");

            // Buscar bloque id="dolar" y el <strong> con la tasa
            var dolarMatch = Regex.Match(html, @"<div[^>]*id=""dolar""[^>]*>.*?<strong[^>]*class=""strong-tb""[^>]*>\s*([0-9.,]+)\s*</strong>", RegexOptions.Singleline | RegexOptions.IgnoreCase);
            if (!dolarMatch.Success)
            {
                dolarMatch = Regex.Match(html, @"<div[^>]*id=""dolar""[^>]*>.*?<strong[^>]*>\s*([0-9.,]+)\s*</strong>", RegexOptions.Singleline | RegexOptions.IgnoreCase);
            }

            if (dolarMatch.Success)
            {
                var rawValue = dolarMatch.Groups[1].Value.Trim().Replace(".", "").Replace(",", ".");
                if (decimal.TryParse(rawValue, NumberStyles.Any, CultureInfo.InvariantCulture, out decimal parsedRate))
                {
                    // Buscar Fecha Valor
                    var dateMatch = Regex.Match(html, @"Fecha\s+Valor:\s*<span[^>]*>([^<]+)</span>", RegexOptions.IgnoreCase);
                    var valueDate = dateMatch.Success ? dateMatch.Groups[1].Value.Trim() : DateTime.Now.ToString("dd/MM/yyyy");

                    return new BcvRateResult
                    {
                        UsdRate = Math.Round(parsedRate, 2),
                        ValueDate = valueDate,
                        LastCheckedAt = DateTime.UtcNow,
                        IsLiveFromBcv = true,
                        Source = "Conexión Directa en Vivo con www.bcv.org.ve"
                    };
                }
            }

            return null;
        }

        private async Task<BcvRateResult?> FetchFromBackupApiAsync()
        {
            var client = _httpClientFactory.CreateClient();
            client.Timeout = TimeSpan.FromSeconds(8);

            var response = await client.GetFromJsonAsync<DolarApiResponse>("https://ve.dolarapi.com/v1/dolares/oficial");
            if (response != null && response.Promedio > 0)
            {
                return new BcvRateResult
                {
                    UsdRate = Math.Round(response.Promedio, 2),
                    ValueDate = response.FechaActualizacion?.ToString("dd/MM/yyyy") ?? DateTime.Now.ToString("dd/MM/yyyy"),
                    LastCheckedAt = DateTime.UtcNow,
                    IsLiveFromBcv = true,
                    Source = "API Oficial de Monitoreo BCV (ve.dolarapi.com)"
                };
            }

            return null;
        }

        private class DolarApiResponse
        {
            [JsonPropertyName("moneda")]
            public string? Moneda { get; set; }

            [JsonPropertyName("promedio")]
            public decimal Promedio { get; set; }

            [JsonPropertyName("fechaActualizacion")]
            public DateTime? FechaActualizacion { get; set; }
        }
    }
}
