using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class UserAddressViewModel
    {


        public int Id { get; set; }

        [Required]
        public string Ad { get; set; }

        [Required]
        public string Soyad { get; set; }

        public string Telefon { get; set; }

        [Required]
        [Display(Name = "İl")]
        public string Il { get; set; }

        [Display(Name = "İlçe")]
        public string Ilce { get; set; }
        public string Mahalle { get; set; }

        [Required]
        [Display(Name = "Adres")]
        public string Adres { get; set; }

        [Required]
        [Display(Name = "Adres Başlığı")]
        public string Baslik { get; set; }

        public bool IsDefault { get; set; }
    }
}
