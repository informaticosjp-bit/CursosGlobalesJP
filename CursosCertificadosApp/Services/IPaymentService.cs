using CursosCertificadosApp.Models.Entities;

namespace CursosCertificadosApp.Services
{
    public interface IPaymentService
    {
        Task<Payment> ProcessAutomaticPaymentAsync(string certificateId, int userId, string paymentMethod, string transactionRef);
        Task<Payment> RegisterManualPaymentAsync(string certificateId, int userId, string paymentMethod, string transactionRef, IFormFile? proofFile);
        Task<Payment> RegisterMembershipPaymentAsync(int userId, string paymentMethod, string transactionRef, IFormFile? proofFile);
        Task<Payment> RegisterCvPaymentAsync(int userId, string paymentMethod, string transactionRef, IFormFile? proofFile);
        Task<bool> ApprovePaymentAsync(int paymentId, string? adminNotes);
        Task<bool> RejectPaymentAsync(int paymentId, string reason);
        Task<List<Payment>> GetPendingPaymentsAsync();
        Task<List<Payment>> GetApprovedPaymentsAsync();
        Task<List<Payment>> GetAllPaymentsAsync();
    }
}
