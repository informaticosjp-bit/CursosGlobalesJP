using CursosCertificadosApp.Data;
using CursosCertificadosApp.Models.Entities;
using CursosCertificadosApp.Models.ViewModels;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;

namespace CursosCertificadosApp.Services
{
    public class SiteSettingService : ISiteSettingService
    {
        private readonly AppDbContext _context;
        private readonly IWebHostEnvironment _env;
        private readonly IMemoryCache _cache;
        private const string CacheKey = "App_SiteCustomizationSettings";
        private const string CertCacheKey = "App_CertificateTemplateSettings";

        public SiteSettingService(AppDbContext context, IWebHostEnvironment env, IMemoryCache cache)
        {
            _context = context;
            _env = env;
            _cache = cache;
        }

        public async Task<SiteCustomizationViewModel> GetSettingsAsync()
        {
            if (_cache.TryGetValue(CacheKey, out SiteCustomizationViewModel? cachedSettings) && cachedSettings != null)
            {
                return cachedSettings;
            }

            var settings = new SiteCustomizationViewModel();

            Dictionary<string, string> dbSettings = new();
            try
            {
                dbSettings = await _context.SystemSettings
                    .Where(s => s.Key.StartsWith("Site_") || s.Key.StartsWith("Footer_") || s.Key.StartsWith("Social_") || s.Key.StartsWith("Popup_"))
                    .ToDictionaryAsync(s => s.Key, s => s.Content);
            }
            catch
            {
                // Si la base de datos aún no está lista o hay fallo de red, se usan los valores por defecto del ViewModel
            }

            if (dbSettings.TryGetValue("Site_Name", out var siteName) && !string.IsNullOrWhiteSpace(siteName))
                settings.SiteName = siteName;

            if (dbSettings.TryGetValue("Site_Name_Highlight", out var highlight))
                settings.SiteNameHighlight = highlight;

            if (dbSettings.TryGetValue("Site_Slogan", out var slogan) && !string.IsNullOrWhiteSpace(slogan))
                settings.SiteSlogan = slogan;

            if (dbSettings.TryGetValue("Site_Logo_Url", out var logoUrl) && !string.IsNullOrWhiteSpace(logoUrl))
                settings.LogoUrl = logoUrl;

            if (dbSettings.TryGetValue("Footer_Description", out var footerDesc) && !string.IsNullOrWhiteSpace(footerDesc))
                settings.FooterDescription = footerDesc;

            if (dbSettings.TryGetValue("Footer_Company_Info", out var companyInfo) && !string.IsNullOrWhiteSpace(companyInfo))
                settings.FooterCompanyInfo = companyInfo;

            if (dbSettings.TryGetValue("Footer_Contact_Email", out var email) && !string.IsNullOrWhiteSpace(email))
                settings.FooterContactEmail = email;

            if (dbSettings.TryGetValue("Footer_Website_Url", out var websiteUrl) && !string.IsNullOrWhiteSpace(websiteUrl))
                settings.FooterWebsiteUrl = websiteUrl;

            if (dbSettings.TryGetValue("Footer_Copyright", out var copyright) && !string.IsNullOrWhiteSpace(copyright))
                settings.FooterCopyright = copyright;

            if (dbSettings.TryGetValue("Footer_Payment_Methods", out var payMethods) && !string.IsNullOrWhiteSpace(payMethods))
                settings.FooterPaymentMethods = payMethods;

            if (dbSettings.TryGetValue("Footer_Payment_Note", out var payNote) && !string.IsNullOrWhiteSpace(payNote))
                settings.FooterPaymentNote = payNote;

            if (dbSettings.TryGetValue("Social_Instagram", out var insta))
                settings.SocialInstagram = insta;

            if (dbSettings.TryGetValue("Social_Whatsapp", out var whatsapp))
                settings.SocialWhatsapp = whatsapp;

            if (dbSettings.TryGetValue("Popup_IsEnabled", out var popupEnabled))
                settings.PopupIsEnabled = bool.TryParse(popupEnabled, out var isEnabled) && isEnabled;

            if (dbSettings.TryGetValue("Popup_Title", out var popupTitle) && !string.IsNullOrWhiteSpace(popupTitle))
                settings.PopupTitle = popupTitle;

            if (dbSettings.TryGetValue("Popup_Message", out var popupMsg))
                settings.PopupMessage = popupMsg;

            if (dbSettings.TryGetValue("Popup_Type", out var popupType) && !string.IsNullOrWhiteSpace(popupType))
                settings.PopupType = popupType;

            if (dbSettings.TryGetValue("Popup_ButtonText", out var popupBtnText) && !string.IsNullOrWhiteSpace(popupBtnText))
                settings.PopupButtonText = popupBtnText;

            if (dbSettings.TryGetValue("Popup_ActionUrl", out var popupActUrl))
                settings.PopupActionUrl = popupActUrl;

            if (dbSettings.TryGetValue("Popup_ActionText", out var popupActText))
                settings.PopupActionText = popupActText;

            if (dbSettings.TryGetValue("Popup_ShowOnce", out var popupShowOnce))
                settings.PopupShowOnce = bool.TryParse(popupShowOnce, out var showOnce) && showOnce;
            else
                settings.PopupShowOnce = false; // Predeterminado: En cada Carga de Página

            if (dbSettings.TryGetValue("Popup_Version", out var popupVer) && !string.IsNullOrWhiteSpace(popupVer))
                settings.PopupVersion = popupVer;

            _cache.Set(CacheKey, settings, TimeSpan.FromHours(6));
            return settings;
        }

        public async Task SaveSettingsAsync(SiteCustomizationViewModel model)
        {
            // Procesar archivo de logo si se cargó uno nuevo
            if (model.LogoFile != null && model.LogoFile.Length > 0)
            {
                var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
                var uploadsDir = Path.Combine(webRoot, "uploads", "brand");
                if (!Directory.Exists(uploadsDir))
                {
                    Directory.CreateDirectory(uploadsDir);
                }

                var ext = Path.GetExtension(model.LogoFile.FileName).ToLowerInvariant();
                var allowedExts = new[] { ".png", ".jpg", ".jpeg", ".svg", ".webp", ".ico" };
                if (allowedExts.Contains(ext))
                {
                    var fileName = $"logo_{DateTime.UtcNow.Ticks}{ext}";
                    var filePath = Path.Combine(uploadsDir, fileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await model.LogoFile.CopyToAsync(stream);
                    }

                    model.LogoUrl = $"/uploads/brand/{fileName}";
                }
            }

            var entries = new Dictionary<string, (string Title, string Content)>
            {
                { "Site_Name", ("Nombre Principal del Sitio", model.SiteName?.Trim() ?? "CURSOS GLOBALES") },
                { "Site_Name_Highlight", ("Resaltado de Marca", model.SiteNameHighlight?.Trim() ?? "") },
                { "Site_Slogan", ("Eslogan del Sitio", model.SiteSlogan?.Trim() ?? "") },
                { "Site_Logo_Url", ("URL o Ruta del Logo", model.LogoUrl?.Trim() ?? "/images/logo-jp.png") },
                { "Footer_Description", ("Descripción en Pie de Página", model.FooterDescription?.Trim() ?? "") },
                { "Footer_Company_Info", ("Razón Social y RIF", model.FooterCompanyInfo?.Trim() ?? "") },
                { "Footer_Contact_Email", ("Correo de Soporte", model.FooterContactEmail?.Trim() ?? "") },
                { "Footer_Website_Url", ("Sitio Web Institucional", model.FooterWebsiteUrl?.Trim() ?? "") },
                { "Footer_Copyright", ("Texto de Copyright", model.FooterCopyright?.Trim() ?? "") },
                { "Footer_Payment_Methods", ("Métodos de Pago", model.FooterPaymentMethods?.Trim() ?? "") },
                { "Footer_Payment_Note", ("Nota de Pago / Tasa", model.FooterPaymentNote?.Trim() ?? "") },
                { "Social_Instagram", ("Instagram", model.SocialInstagram?.Trim() ?? "") },
                { "Social_Whatsapp", ("WhatsApp", model.SocialWhatsapp?.Trim() ?? "") }
            };

            foreach (var (key, (title, content)) in entries)
            {
                var existing = await _context.SystemSettings.FirstOrDefaultAsync(s => s.Key == key);
                if (existing == null)
                {
                    _context.SystemSettings.Add(new SystemSetting
                    {
                        Key = key,
                        Title = title,
                        Content = content,
                        UpdatedAt = DateTime.UtcNow
                    });
                }
                else
                {
                    existing.Title = title;
                    existing.Content = content;
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }

            await _context.SaveChangesAsync();
            _cache.Remove(CacheKey);
        }

        public async Task SavePopupSettingsAsync(PopupSettingViewModel model)
        {
            var entries = new Dictionary<string, (string Title, string Content)>
            {
                { "Popup_IsEnabled", ("Popup Activado", model.IsEnabled ? "true" : "false") },
                { "Popup_Title", ("Título del Popup", model.Title?.Trim() ?? "Aviso Importante") },
                { "Popup_Message", ("Mensaje del Popup", model.Message?.Trim() ?? "") },
                { "Popup_Type", ("Estilo Visual del Popup", model.Type ?? "warning") },
                { "Popup_ButtonText", ("Texto del Botón", model.ButtonText?.Trim() ?? "Entendido") },
                { "Popup_ActionUrl", ("Enlace Opcional de Acción", model.ActionUrl?.Trim() ?? "") },
                { "Popup_ActionText", ("Texto del Enlace Opcional", model.ActionText?.Trim() ?? "") },
                { "Popup_ShowOnce", ("Mostrar Solo Primera Vez", model.ShowOnce ? "true" : "false") },
                { "Popup_Version", ("Versión del Popup", model.Version ?? DateTime.UtcNow.ToString("yyyyMMddHHmmss")) }
            };

            foreach (var (key, (title, content)) in entries)
            {
                var existing = await _context.SystemSettings.FirstOrDefaultAsync(s => s.Key == key);
                if (existing == null)
                {
                    _context.SystemSettings.Add(new SystemSetting
                    {
                        Key = key,
                        Title = title,
                        Content = content,
                        UpdatedAt = DateTime.UtcNow
                    });
                }
                else
                {
                    existing.Title = title;
                    existing.Content = content;
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }

            await _context.SaveChangesAsync();
            _cache.Remove(CacheKey);
        }

        public async Task ResetToDefaultsAsync()
        {
            var keysToRemove = new[]
            {
                "Site_Name", "Site_Name_Highlight", "Site_Slogan", "Site_Logo_Url",
                "Footer_Description", "Footer_Company_Info", "Footer_Contact_Email",
                "Footer_Website_Url", "Footer_Copyright", "Footer_Payment_Methods",
                "Footer_Payment_Note", "Social_Instagram", "Social_Whatsapp"
            };

            var toRemove = await _context.SystemSettings
                .Where(s => keysToRemove.Contains(s.Key))
                .ToListAsync();

            if (toRemove.Count > 0)
            {
                _context.SystemSettings.RemoveRange(toRemove);
                await _context.SaveChangesAsync();
            }

            _cache.Remove(CacheKey);
        }

        public async Task<CertificateTemplateViewModel> GetCertificateTemplateAsync()
        {
            if (_cache.TryGetValue(CertCacheKey, out CertificateTemplateViewModel? cached) && cached != null)
            {
                return cached;
            }

            var settings = new CertificateTemplateViewModel();
            Dictionary<string, string> dbSettings = new();
            try
            {
                dbSettings = await _context.SystemSettings
                    .Where(s => s.Key.StartsWith("Cert_"))
                    .ToDictionaryAsync(s => s.Key, s => s.Content);
            }
            catch
            {
            }

            ApplyCertificateSettings(settings, dbSettings);
            _cache.Set(CertCacheKey, settings, TimeSpan.FromHours(6));
            return settings;
        }

        public CertificateTemplateViewModel GetCertificateTemplateSync()
        {
            if (_cache.TryGetValue(CertCacheKey, out CertificateTemplateViewModel? cached) && cached != null)
            {
                return cached;
            }

            var settings = new CertificateTemplateViewModel();
            Dictionary<string, string> dbSettings = new();
            try
            {
                dbSettings = _context.SystemSettings
                    .Where(s => s.Key.StartsWith("Cert_"))
                    .ToDictionary(s => s.Key, s => s.Content);
            }
            catch
            {
            }

            ApplyCertificateSettings(settings, dbSettings);
            _cache.Set(CertCacheKey, settings, TimeSpan.FromHours(6));
            return settings;
        }

        private static void ApplyCertificateSettings(CertificateTemplateViewModel settings, Dictionary<string, string> dbSettings)
        {
            if (dbSettings.TryGetValue("Cert_InstitutionName", out var instName) && !string.IsNullOrWhiteSpace(instName))
                settings.InstitutionName = instName;

            if (dbSettings.TryGetValue("Cert_InstitutionHighlight", out var instHighlight))
                settings.InstitutionHighlight = instHighlight;

            if (dbSettings.TryGetValue("Cert_HeaderSubtitle", out var subtitle) && !string.IsNullOrWhiteSpace(subtitle))
                settings.HeaderSubtitle = subtitle;

            if (dbSettings.TryGetValue("Cert_LogoUrl", out var logoUrl) && !string.IsNullOrWhiteSpace(logoUrl))
                settings.LogoUrl = logoUrl;

            if (dbSettings.TryGetValue("Cert_CertificateTitle", out var certTitle) && !string.IsNullOrWhiteSpace(certTitle))
                settings.CertificateTitle = certTitle;

            if (dbSettings.TryGetValue("Cert_AccreditationBadgeText", out var badgeText) && !string.IsNullOrWhiteSpace(badgeText))
                settings.AccreditationBadgeText = badgeText;

            if (dbSettings.TryGetValue("Cert_GrantingIntroText", out var introText) && !string.IsNullOrWhiteSpace(introText))
                settings.GrantingIntroText = introText;

            if (dbSettings.TryGetValue("Cert_SideDescription", out var sideDesc) && !string.IsNullOrWhiteSpace(sideDesc))
                settings.SideDescription = sideDesc;

            if (dbSettings.TryGetValue("Cert_DeveloperOrgName", out var devOrg) && !string.IsNullOrWhiteSpace(devOrg))
                settings.DeveloperOrgName = devOrg;

            if (dbSettings.TryGetValue("Cert_AuthorityTitle", out var authTitle) && !string.IsNullOrWhiteSpace(authTitle))
                settings.AuthorityTitle = authTitle;

            if (dbSettings.TryGetValue("Cert_CompanyLegalName", out var companyName) && !string.IsNullOrWhiteSpace(companyName))
                settings.CompanyLegalName = companyName;

            if (dbSettings.TryGetValue("Cert_VerificationDomain", out var domain) && !string.IsNullOrWhiteSpace(domain))
                settings.VerificationDomain = domain;

            if (dbSettings.TryGetValue("Cert_VerificationDisclaimer", out var disclaimer) && !string.IsNullOrWhiteSpace(disclaimer))
                settings.VerificationDisclaimer = disclaimer;
        }

        public async Task SaveCertificateTemplateAsync(CertificateTemplateViewModel model)
        {
            // Procesar archivo de logo si se cargó uno nuevo
            if (model.LogoFile != null && model.LogoFile.Length > 0)
            {
                var webRoot = _env.WebRootPath ?? Path.Combine(_env.ContentRootPath, "wwwroot");
                var uploadsDir = Path.Combine(webRoot, "uploads", "cert-brand");
                if (!Directory.Exists(uploadsDir))
                {
                    Directory.CreateDirectory(uploadsDir);
                }

                var ext = Path.GetExtension(model.LogoFile.FileName).ToLowerInvariant();
                var allowedExts = new[] { ".png", ".jpg", ".jpeg", ".svg", ".webp" };
                if (allowedExts.Contains(ext))
                {
                    var fileName = $"cert_logo_{DateTime.UtcNow.Ticks}{ext}";
                    var filePath = Path.Combine(uploadsDir, fileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await model.LogoFile.CopyToAsync(stream);
                    }

                    model.LogoUrl = $"/uploads/cert-brand/{fileName}";
                }
            }

            var entries = new Dictionary<string, (string Title, string Content)>
            {
                { "Cert_InstitutionName", ("Nombre de Institución en Certificado", model.InstitutionName?.Trim() ?? "CURSOS GLOBALES") },
                { "Cert_InstitutionHighlight", ("Resaltado de Institución", model.InstitutionHighlight?.Trim() ?? "JP") },
                { "Cert_HeaderSubtitle", ("Subtítulo del Membrete", model.HeaderSubtitle?.Trim() ?? "Aprendizaje Online") },
                { "Cert_LogoUrl", ("Ruta del Logo del Certificado", model.LogoUrl?.Trim() ?? "/images/logo-jp.png") },
                { "Cert_CertificateTitle", ("Título del Certificado", model.CertificateTitle?.Trim() ?? "CERTIFICADO DE FINALIZACIÓN") },
                { "Cert_AccreditationBadgeText", ("Etiqueta de Acreditación", model.AccreditationBadgeText?.Trim() ?? "ACREDITACIÓN VERIFICABLE") },
                { "Cert_GrantingIntroText", ("Texto Introductorio", model.GrantingIntroText?.Trim() ?? "Certificado de finalización de") },
                { "Cert_SideDescription", ("Descripción Lateral", model.SideDescription?.Trim() ?? "") },
                { "Cert_DeveloperOrgName", ("Entidad Emisora", model.DeveloperOrgName?.Trim() ?? "Cursos Globales JP") },
                { "Cert_AuthorityTitle", ("Cargo Firmante", model.AuthorityTitle?.Trim() ?? "Dirección Académica") },
                { "Cert_CompanyLegalName", ("Razón Social Legal", model.CompanyLegalName?.Trim() ?? "Inversiones Globales JP 1968, C.A.") },
                { "Cert_VerificationDomain", ("Dominio de Validación", model.VerificationDomain?.Trim() ?? "https://cursos.globalesjp.net") },
                { "Cert_VerificationDisclaimer", ("Nota Explicativa de Validación", model.VerificationDisclaimer?.Trim() ?? "") }
            };

            foreach (var (key, (title, content)) in entries)
            {
                var existing = await _context.SystemSettings.FirstOrDefaultAsync(s => s.Key == key);
                if (existing == null)
                {
                    _context.SystemSettings.Add(new SystemSetting
                    {
                        Key = key,
                        Title = title,
                        Content = content,
                        UpdatedAt = DateTime.UtcNow
                    });
                }
                else
                {
                    existing.Title = title;
                    existing.Content = content;
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }

            await _context.SaveChangesAsync();
            _cache.Remove(CertCacheKey);
        }

        public async Task ResetCertificateTemplateToDefaultsAsync()
        {
            var keysToRemove = new[]
            {
                "Cert_InstitutionName", "Cert_InstitutionHighlight", "Cert_HeaderSubtitle", "Cert_LogoUrl",
                "Cert_CertificateTitle", "Cert_AccreditationBadgeText", "Cert_GrantingIntroText", "Cert_SideDescription",
                "Cert_DeveloperOrgName", "Cert_AuthorityTitle", "Cert_CompanyLegalName",
                "Cert_VerificationDomain", "Cert_VerificationDisclaimer"
            };

            var toRemove = await _context.SystemSettings
                .Where(s => keysToRemove.Contains(s.Key))
                .ToListAsync();

            if (toRemove.Count > 0)
            {
                _context.SystemSettings.RemoveRange(toRemove);
                await _context.SaveChangesAsync();
            }

            _cache.Remove(CertCacheKey);
        }
    }
}
