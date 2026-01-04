using System;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class ProfileViewModel
    {
        public ProfileInfoViewModel Profile { get; set; }
        public ChangePasswordViewModel Password { get; set; }
    }
}
