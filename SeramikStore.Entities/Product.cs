using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace SeramikStore.Entities
{
    public class Product
    {
        public int Id { get; set; }                // Primary Key
        public string ProductCode { get; set; }     // Product code (nvarchar(50))
        public string ProductName { get; set; }     // Product name (nvarchar(50))
        public string ProductDesc { get; set; }     // Product description (nvarchar(max))
        public int CategoryId { get; set; }         // Category ID (int)
        public decimal UnitPrice { get; set; }          // Price (decimal(18, 0))
        public string Currency { get; set; }        // Currency (nvarchar(10))
        public bool AvailableForSale { get; set; }  // Available for sale (bit)
    }
}
