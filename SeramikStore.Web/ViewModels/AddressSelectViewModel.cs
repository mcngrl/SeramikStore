using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class AddressSelectViewModel
    {
        public List<UserAddressViewModel> Addresses { get; set; }

        [Required(ErrorMessage = "Lütfen bir adres seçiniz")]
        public int? SelectedAddressId { get; set; }

        [Range(typeof(bool), "true", "true",
            ErrorMessage = "Devam edebilmek için sözleşmeyi onaylamalısınız")]
        public bool TermsAccepted { get; set; }

        public decimal ProductTotal { get; set; }
        public decimal CargoPrice { get; set; }
        //public decimal GrandTotal => ProductTotal + CargoPrice;

        public decimal GrandTotal { get; set; }
    }
}
