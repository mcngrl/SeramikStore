using System.ComponentModel.DataAnnotations;

public class ChangePasswordViewModel
{
    [Required]
    [Display(Name = "Şu Anki Şifre")]
    public string CurrentPassword { get; set; }

    [Required]
    [Display(Name = "Yeni Şifre")]
    public string NewPassword { get; set; }

    [Compare("NewPassword")]
    [Display(Name = "Yeni Şifre (Tekrar)")]
    public string ConfirmNewPassword { get; set; }
}
