using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class AddressSelectPostModel
    {
        [Required(ErrorMessage = "Adres seçmek zorunludur")]
        public int? SelectedAddressId { get; set; }

        [Range(typeof(bool), "true", "true",
        ErrorMessage = "Devam edebilmek için sözleşmeyi onaylamalısınız")]
        public bool TermsAccepted { get; set; }
    }

}
