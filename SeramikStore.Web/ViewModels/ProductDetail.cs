using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels
{
    public class ProductDetail
    {
        public int Id { get; set; }                // Primary Key
        public string ProductCode { get; set; }     // Product code (nvarchar(50))
        public string ProductName { get; set; }     // Product name (nvarchar(50))
        public string ProductDesc { get; set; }     // Product description (nvarchar(max))
        public decimal UnitPrice { get; set; }          // Price (decimal(18, 0))
        public string CurrencyCode { get; set; }        
        public string CurrencySymbol { get; set; }       
  
        [Required(ErrorMessage = "Adet zorunludur")]
        [Range(1, 1000, ErrorMessage = "Adet en az 1 olmalıdır")]
        public int Quantity { get; set; } = 1;
        public bool AvailableForSale { get; set; }  // Available for sale (bit)

        public List<string> ImagePaths { get; set; }
    }
}
