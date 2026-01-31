using SeramikStore.Web.Localization;
using System;
using System.ComponentModel.DataAnnotations;
namespace SeramikStore.Web.ViewModels.Account
{
    public class RegisterViewModel
    {

        [Required(ErrorMessage = "{0} alanı zorunludur.")]
        [Display(Name = "Ad")]
        public string FirstName { get; set; }


        [Required(ErrorMessage = "{0} alanı zorunludur.")]
        [Display(Name = "Soyad")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "{0} alanı zorunludur.")]
        [EmailAddress]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "{0} alanı zorunludur.")]
        [DataType(DataType.Password)]
        [MinLength(6)]
        [Display(Name = "Şifre")]
        public string Password { get; set; }

     
        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "Şifreler uyuşmuyor")]
        [Display(Name = "Şifre Tekrar")]
        public string ConfirmPassword { get; set; }

        [Required]
        [Display(Name = "Cep Telefonu")]
        [RegularExpression(
          @"^\(5\d{2}\)\s\d{3}\s\d{2}\s\d{2}$",
          ErrorMessage = "Telefon numarası (5XX) XXX XX XX formatında olmalıdır"
      )]
        public string PhoneNumber { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Doğum Tarihi")]
        public DateTime? BirthDate { get; set; }



        // ===============================
        // SÖZLEŞME & KVKK
        // ===============================

        [Range(typeof(bool), "true", "true",
            ErrorMessage = "Üyelik sözleşmesini kabul etmelisiniz")]
        public bool AcceptMembershipAgreement { get; set; }

        [Range(typeof(bool), "true", "true",
            ErrorMessage = "KVKK aydınlatma metnini kabul etmelisiniz")]
        public bool AcceptKvkk { get; set; }

        // server-side log
        public string? AgreementAcceptedIp { get; set; }

        // ===============================
        // LOG / HUKUKİ KAYIT (server set eder)
        // ===============================

    }
}