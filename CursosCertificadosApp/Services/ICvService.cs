using CursosCertificadosApp.Models.Entities;
using CursosCertificadosApp.Models.ViewModels;

namespace CursosCertificadosApp.Services
{
    public interface ICvService
    {
        Task<CvViewModel> GetOrCreateUserCvAsync(int userId);
        Task<bool> SaveUserCvAsync(int userId, CvViewModel model);
        Task<bool> IsCvUnlockedForUserAsync(int userId);
        Task<bool> HasPendingCvPaymentAsync(int userId);
        string GenerateProfessionalSummaryAi(IaSummaryRequest request);
        Task<List<CvCertificationItem>> GetUserPlatformCertificatesAsync(int userId);
    }
}
