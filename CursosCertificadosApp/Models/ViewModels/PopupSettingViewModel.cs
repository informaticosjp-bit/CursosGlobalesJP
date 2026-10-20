using System.ComponentModel.DataAnnotations;

namespace CursosCertificadosApp.Models.ViewModels
{
    public class PopupSettingViewModel
    {
        [Display(Name = "¿Activar Popup / Anuncio?")]
        public bool IsEnabled { get; set; } = false;

        [Display(Name = "Título del Anuncio")]
        [Required(ErrorMessage = "El título del anuncio es obligatorio")]
        [MaxLength(150)]
        public string Title { get; set; } = "Aviso de Mantenimiento Programado";

        [Display(Name = "Contenido del Anuncio")]
        [Required(ErrorMessage = "El mensaje del anuncio es obligatorio")]
        public string Message { get; set; } = "Estimados usuarios:\n\nEstaremos realizando labores de mantenimiento y optimización en la plataforma. Durante este breve lapso algunos servicios podrían experimentar intermitencias temporales.\n\nAgradecemos su paciencia y comprensión.";

        [Display(Name = "Tipo de Anuncio / Nivel de Alerta")]
        public string Type { get; set; } = "warning"; // warning, info, danger, success, primary

        [Display(Name = "Texto del Botón de Cierre")]
        [MaxLength(50)]
        public string ButtonText { get; set; } = "Entendido";

        [Display(Name = "Enlace Opcional de Acción (URL)")]
        [MaxLength(300)]
        public string? ActionUrl { get; set; }

        [Display(Name = "Texto del Enlace Opcional")]
        [MaxLength(50)]
        public string? ActionText { get; set; }

        [Display(Name = "Frecuencia de Visualización")]
        public bool ShowOnce { get; set; } = false; // Predeterminado: false = En cada Carga de Página

        public string Version { get; set; } = "1";
    }
}
