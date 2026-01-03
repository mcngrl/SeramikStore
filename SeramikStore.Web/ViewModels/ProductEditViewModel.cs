using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Microsoft.AspNetCore.Mvc.Rendering;
using SeramikStore.Entities;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class ProductEditViewModel
    {
        public int Id { get; set; }    

        [Display(Name = "Ürün Kodu")]
        public string ProductCode { get; set; }     // Product code (nvarchar(50))
        public string ProductName { get; set; }     // Product name (nvarchar(50))
        public string ProductDesc { get; set; }     // Product description (nvarchar(max))
        public int CategoryId { get; set; }         // Category ID (int)

        [Required(ErrorMessage = "Fiyat zorunludur")]
        [TurkishDecimal]
        public string UnitPrice { get; set; }       
        public int CurrencyId { get; set; }        // Currency (nvarchar(10))
        public bool AvailableForSale { get; set; }  // Available for sale (bit)

        [ValidateNever]
        public List<SelectListItem> Currencies { get; set; }


        [ValidateNever]
        public List<SelectListItem> Categories { get; set; }



    }

}
