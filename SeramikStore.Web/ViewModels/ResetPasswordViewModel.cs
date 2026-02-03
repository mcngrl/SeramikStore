using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class ResetPasswordViewModel
    {
        [Required]
        public string Token { get; set; }   // Email ile gelen token

        [Required]
        [EmailAddress]
        [Display(Name = "E‑posta")]
        public string Email { get; set; }

        [Required(ErrorMessage = "{0} alanı zorunludur.")]
        [DataType(DataType.Password)]
        [MinLength(6, ErrorMessage = "Şifre en az 6 karakter olmalıdır.")]
        [Display(Name = "Yeni Şifre")]
        public string Password { get; set; }

        [Required(ErrorMessage = "{0} alanı zorunludur.")]
        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "Şifreler uyuşmuyor")]
        [Display(Name = "Yeni Şifre (Tekrar)")]
        public string ConfirmPassword { get; set; }
    }
}
