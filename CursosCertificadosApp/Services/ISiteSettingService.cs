using CursosCertificadosApp.Models.ViewModels;

namespace CursosCertificadosApp.Services
{
    public interface ISiteSettingService
    {
        Task<SiteCustomizationViewModel> GetSettingsAsync();
        Task SaveSettingsAsync(SiteCustomizationViewModel model);
        Task SavePopupSettingsAsync(PopupSettingViewModel model);
        Task ResetToDefaultsAsync();
    }
}
