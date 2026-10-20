using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CursosCertificadosApp.Models.Entities
{
    public enum CertificateStatus
    {
        Locked = 0,         // Curso y examen aprobados, borrador generado con marca de agua (no descargable)
        PendingPayment = 1, // Pago manual enviado en espera de validación administrativa
        Issued = 2          // Pagado y emitido oficialmente para descarga y validación pública
    }

    public class Certificate
    {
        [Key, MaxLength(40)]
        public string Id { get; set; } = Guid.NewGuid().ToString("N");

        [Required, MaxLength(50)]
        public string VerificationCode { get; set; } = string.Empty; // Ej: CGJP-2026-X89K2

        public int UserId { get; set; }
        public User User { get; set; } = null!;

        public int CourseId { get; set; }
        public Course Course { get; set; } = null!;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public DateTime? IssuedAt { get; set; }

        public CertificateStatus Status { get; set; } = CertificateStatus.Locked;

        [Column(TypeName = "decimal(5,2)")]
        public decimal? QuizScore { get; set; }

        [MaxLength(250)]
        public string? WatermarkPreviewUrl { get; set; }

        [MaxLength(250)]
        public string? FinalPdfPath { get; set; }

        public string? QrCodeBase64 { get; set; }

        public ICollection<Payment> Payments { get; set; } = new List<Payment>();
    }
}
