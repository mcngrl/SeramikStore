using System;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class VerifyEmailViewModel
    {
        public string Email { get; set; }
        public string Code { get; set; }
    }
}
