using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.ViewModels
{
    public class SiteCustomizationViewModel
    {
        // ==========================================
        // 1. Identidad de Marca y Cabecera
        // ==========================================
        [Display(Name = "Nombre Principal del Sitio")]
        [Required(ErrorMessage = "El nombre del sitio es obligatorio")]
        [MaxLength(100)]
        public string SiteName { get; set; } = "CURSOS GLOBALES";

        [Display(Name = "Resaltado / Siglas de Marca")]
        [MaxLength(30)]
        public string SiteNameHighlight { get; set; } = "JP";

        [Display(Name = "Lema o Eslogan")]
        [MaxLength(200)]
        public string SiteSlogan { get; set; } = "Aprende Gratis - Certifícate por $1 USD";

        [Display(Name = "Ruta o URL del Logo")]
        [MaxLength(500)]
        public string LogoUrl { get; set; } = "/images/logo-jp.png";

        [Display(Name = "Subir Nuevo Archivo de Logo")]
        public IFormFile? LogoFile { get; set; }

        // ==========================================
        // 2. Pie de Página (Footer)
        // ==========================================
        [Display(Name = "Descripción Breve del Sitio")]
        [MaxLength(600)]
        public string FooterDescription { get; set; } = "Democratizando la formación técnica, digital y empresarial. Conocimiento libre sin barreras y certificación oficial verificable por solo 1 dólar.";

        [Display(Name = "Razón Social e Identificación Fiscal (RIF/DNI)")]
        [MaxLength(200)]
        public string FooterCompanyInfo { get; set; } = "Inversiones Globales JP 1968, C.A. • RIF: J-41102463-5";

        [Display(Name = "Correo Electrónico de Contacto / Soporte")]
        [EmailAddress(ErrorMessage = "Ingrese un correo válido")]
        [MaxLength(150)]
        public string FooterContactEmail { get; set; } = "soporte@globalesjp.net";

        [Display(Name = "URL del Sitio Web Institucional")]
        [MaxLength(250)]
        public string FooterWebsiteUrl { get; set; } = "https://globalesjp.net";

        [Display(Name = "Texto de Derechos Reservados / Copyright")]
        [MaxLength(300)]
        public string FooterCopyright { get; set; } = "Cursos Globales JP (globalesjp.net). Plataforma de Certificación Profesional. Todos los derechos reservados.";

        [Display(Name = "Métodos de Pago Visibles")]
        [MaxLength(250)]
        public string FooterPaymentMethods { get; set; } = "Pago Móvil, Transferencia Bancaria, Binance Pay, USDT";

        [Display(Name = "Nota de Pago / Tasa Oficial")]
        [MaxLength(200)]
        public string FooterPaymentNote { get; set; } = "Pagos en bolívares a la tasa oficial del BCV";

        // ==========================================
        // 3. Redes Sociales / Canales de Contacto
        // ==========================================
        [Display(Name = "Enlace de Instagram")]
        [MaxLength(200)]
        public string? SocialInstagram { get; set; }

        [Display(Name = "Número o Enlace de WhatsApp")]
        [MaxLength(200)]
        public string? SocialWhatsapp { get; set; }

        // ==========================================
        // 4. Anuncios y Popups para Visitantes
        // ==========================================
        [Display(Name = "Activar Popup / Anuncio")]
        public bool PopupIsEnabled { get; set; } = true;

        [Display(Name = "Título del Anuncio")]
        [MaxLength(150)]
        public string PopupTitle { get; set; } = "Mantenimiento Programado del Sistema";

        [Display(Name = "Mensaje del Anuncio")]
        public string PopupMessage { get; set; } = "Estimados usuarios y estudiantes:\n\nNos encontramos realizando labores de mantenimiento técnico y actualización en los servidores de la plataforma.\n\nDurante este breve período algunos accesos podrían experimentar demoras temporales. El servicio volverá a operar con total normalidad a la brevedad.\n\nAgradecemos su valiosa comprensión.";

        [Display(Name = "Estilo / Tipo de Alerta")]
        public string PopupType { get; set; } = "warning"; // warning, info, danger, success, primary

        [Display(Name = "Texto del Botón de Cierre")]
        [MaxLength(50)]
        public string PopupButtonText { get; set; } = "Entendido";

        [Display(Name = "Enlace Opcional de Acción")]
        [MaxLength(300)]
        public string? PopupActionUrl { get; set; }

        [Display(Name = "Texto del Enlace Opcional")]
        [MaxLength(50)]
        public string? PopupActionText { get; set; }

        [Display(Name = "Frecuencia de Visualización")]
        public bool PopupShowOnce { get; set; } = false; // false = en cada carga para que el aviso de mantenimiento sea visible de inmediato

        public string PopupVersion { get; set; } = "1";

        public string PopupHeaderClass => PopupType switch
        {
            "danger" => "bg-danger text-white",
            "warning" => "bg-warning text-dark",
            "success" => "bg-success text-white",
            "info" => "bg-info text-dark",
            _ => "bg-primary text-white"
        };

        public string PopupIconClass => PopupType switch
        {
            "danger" => "bi-exclamation-octagon-fill",
            "warning" => "bi-tools",
            "success" => "bi-stars",
            "info" => "bi-info-circle-fill",
            _ => "bi-megaphone-fill"
        };
    }
}
