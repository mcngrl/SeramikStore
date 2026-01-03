using System;
using System.ComponentModel.DataAnnotations;

public class RegisterViewModel
{
    [Required]
    [Display(Name = "Ad")]
    public string FirstName { get; set; }

    [Required]
    [Display(Name = "Soyad")]
    public string LastName { get; set; }

    [Required]
    [EmailAddress]
    public string Email { get; set; }

    [Required]
    [DataType(DataType.Password)]
    [MinLength(6)]
    public string Password { get; set; }

    [Required]
    [DataType(DataType.Password)]
    [Compare("Password", ErrorMessage = "Şifreler uyuşmuyor")]
    [Display(Name = "Şifre Tekrar")]
    public string ConfirmPassword { get; set; }

    [Phone]
    [Display(Name = "Cep Telefonu")]
    public string PhoneNumber { get; set; }

    [DataType(DataType.Date)]
    [Display(Name = "Doğum Tarihi")]
    public DateTime? BirthDate { get; set; }
}
