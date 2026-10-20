using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Services
{
    public interface ICertificateService
    {
        Task<Certificate> GenerateLockedCertificateAsync(int enrollmentId, decimal? quizScore = null);
        Task<Certificate?> IssueCertificateAsync(string certificateId);
        Task<Certificate?> GetCertificateByIdAsync(string certificateId);
        Task<Certificate?> GetCertificateByVerificationCodeAsync(string code);
        byte[] GenerateOfficialPdf(Certificate certificate);
    }
}
