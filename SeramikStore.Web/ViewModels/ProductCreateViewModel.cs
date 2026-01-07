using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Microsoft.AspNetCore.Mvc.Rendering;
using SeramikStore.Entities;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class ProductCreateViewModel
    {
        public int Id { get; set; }

        [Display(Name = "Ürün Kodu")]
        [MaxLength(50)]
        public string ProductCode { get; set; }     // Product code (nvarchar(50))

        [Display(Name = "Ürün Tanımı")]
        [MaxLength(255)]
        public string ProductName { get; set; }     // Product name (nvarchar(50))

        [Display(Name = "Ürün Açıklama")]
        public string ProductDesc { get; set; }     // Product description (nvarchar(max))
        public int CategoryId { get; set; }         // Category ID (int)

        [Required(ErrorMessage = "Fiyat zorunludur")]
        [TurkishDecimal]
        [Display(Name = "Birim Fiyat")]
        public string UnitPrice { get; set; }

        [Display(Name = "Para Birimi")]
        public int CurrencyId { get; set; }        // Currency (nvarchar(10))

        [Display(Name = "Satış için hazır")]
        public bool AvailableForSale { get; set; }  // Available for sale (bit)

        [ValidateNever]
        public List<SelectListItem> Currencies { get; set; }


        [ValidateNever]
        public List<SelectListItem> Categories { get; set; }



    }

}
