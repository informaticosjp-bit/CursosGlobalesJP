using CursosCertificadosApp.Models.ViewModels;

namespace CursosCertificadosApp.Services
{
    public interface ISiteSettingService
    {
        Task<SiteCustomizationViewModel> GetSettingsAsync();
        Task SaveSettingsAsync(SiteCustomizationViewModel model);
        Task SavePopupSettingsAsync(PopupSettingViewModel model);
        Task ResetToDefaultsAsync();

        Task<CertificateTemplateViewModel> GetCertificateTemplateAsync();
        CertificateTemplateViewModel GetCertificateTemplateSync();
        Task SaveCertificateTemplateAsync(CertificateTemplateViewModel model);
        Task ResetCertificateTemplateToDefaultsAsync();
    }
}
