using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.ViewModels
{
    public class CertificateTemplateViewModel
    {
        // ==========================================
        // 1. Membrete e Institución (Panel Lateral y Cabecera)
        // ==========================================
        [Display(Name = "Nombre Principal de la Institución / Empresa")]
        [Required(ErrorMessage = "El nombre de la institución es obligatorio"), MaxLength(100)]
        public string InstitutionName { get; set; } = "CURSOS GLOBALES";

        [Display(Name = "Resaltado / Siglas")]
        [MaxLength(30)]
        public string InstitutionHighlight { get; set; } = "JP";

        [Display(Name = "Subtítulo de Membrete")]
        [MaxLength(100)]
        public string HeaderSubtitle { get; set; } = "Aprendizaje Online";

        [Display(Name = "Ruta o URL del Logo del Certificado")]
        [MaxLength(500)]
        public string LogoUrl { get; set; } = "/images/logo-jp.png";

        [Display(Name = "Subir Nuevo Logo para el Certificado")]
        public IFormFile? LogoFile { get; set; }

        // ==========================================
        // 2. Encabezado del Diploma
        // ==========================================
        [Display(Name = "Título Principal del Diploma")]
        [Required(ErrorMessage = "El título del certificado es obligatorio"), MaxLength(100)]
        public string CertificateTitle { get; set; } = "CERTIFICADO DE FINALIZACIÓN";

        [Display(Name = "Etiqueta Superior de Acreditación")]
        [MaxLength(80)]
        public string AccreditationBadgeText { get; set; } = "ACREDITACIÓN VERIFICABLE";

        [Display(Name = "Texto Introductorio del Otorgamiento")]
        [MaxLength(150)]
        public string GrantingIntroText { get; set; } = "Certificado de finalización de";

        // ==========================================
        // 3. Panel Lateral Descriptivo
        // ==========================================
        [Display(Name = "Texto Descriptivo del Panel Lateral")]
        [MaxLength(300)]
        public string SideDescription { get; set; } = "Credencial oficial electrónica con código de verificación emitida por la plataforma de capacitación continua.";

        // ==========================================
        // 4. Firmante y Respaldo Institucional
        // ==========================================
        [Display(Name = "Entidad Emisora / Desarrollador del Contenido")]
        [MaxLength(150)]
        public string DeveloperOrgName { get; set; } = "Cursos Globales JP";

        [Display(Name = "Cargo / Departamento Firmante")]
        [MaxLength(150)]
        public string AuthorityTitle { get; set; } = "Dirección Académica y Certificación";

        [Display(Name = "Razón Social o Sello Institucional")]
        [MaxLength(150)]
        public string CompanyLegalName { get; set; } = "Inversiones Globales JP 1968, C.A.";

        // ==========================================
        // 5. Verificación y Pie de Página
        // ==========================================
        [Display(Name = "URL o Dominio Oficial de Verificación")]
        [MaxLength(250)]
        public string VerificationDomain { get; set; } = "https://cursos.globalesjp.net";

        [Display(Name = "Texto de Validación QR al Pie")]
        [MaxLength(300)]
        public string VerificationDisclaimer { get; set; } = "Para validar la autenticidad y vigencia de esta credencial académica, ingrese a:";
    }
}
