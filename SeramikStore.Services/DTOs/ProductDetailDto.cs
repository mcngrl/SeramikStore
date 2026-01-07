using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services.DTOs
{
    public class ProductDetailDto
    {
        public int Id { get; set; }                // Primary Key
        public string ProductCode { get; set; }     // Product code (nvarchar(50))
        public string ProductName { get; set; }     // Product name (nvarchar(50))
        public string ProductDesc { get; set; }     // Product description (nvarchar(max))
        public int CategoryId { get; set; }         // Category ID (int)
        public decimal UnitPrice { get; set; }          // Price (decimal(18, 0))
        public int CurrencyId { get; set; }
        public bool AvailableForSale { get; set; }  // Available for sale (bit)
        public int DisplayOrderNo { get; set; }
        public string CurrencyCode { get; set; }
        public string CurrencySymbol { get; set; }
        public string CategoryName { get; set; }
    }
}
