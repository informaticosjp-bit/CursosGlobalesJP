using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CursosCertificadosApp.Models.Entities
{
    public class Payment
    {
        public int Id { get; set; }

        [MaxLength(40)]
        public string? CertificateId { get; set; }
        public Certificate? Certificate { get; set; }

        public int UserId { get; set; }
        public User User { get; set; } = null!;

        [MaxLength(50)]
        public string PaymentType { get; set; } = "Certificate"; // "Certificate" ($1 USD) o "CreatorMembership" ($10 USD)

        [Column(TypeName = "decimal(18,2)")]
        public decimal Amount { get; set; } = 1.00m;

        [Required, MaxLength(50)]
        public string PaymentMethod { get; set; } = "PagoMovil"; // "Pago Móvil (BDV)", "Transferencia Bancaria (BDV)", "Binance Pay"

        [Required, MaxLength(100)]
        public string TransactionReference { get; set; } = string.Empty;

        [MaxLength(300)]
        public string? ProofImageUrl { get; set; } // Comprobante / voucher cargado para pagos manuales

        [Required, MaxLength(30)]
        public string Status { get; set; } = "Pending"; // "Pending", "Approved", "Rejected"

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public DateTime? ProcessedAt { get; set; }

        [MaxLength(250)]
        public string? AdminNotes { get; set; }
    }
}
