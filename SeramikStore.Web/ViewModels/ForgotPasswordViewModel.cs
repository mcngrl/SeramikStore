using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class ForgotPasswordViewModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
    }

}
