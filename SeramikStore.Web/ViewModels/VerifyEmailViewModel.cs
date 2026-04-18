using System;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class VerifyEmailViewModel
    {
        public string Email { get; set; }

        [Required(ErrorMessage = "Doğrulama Kodunu Giriniz.")]
        public string Code { get; set; }
    }
}
