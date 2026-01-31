using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class LoginViewModel
    {
        [Display(Name ="User Name")]
        public string UserName { get; set; }

        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}
