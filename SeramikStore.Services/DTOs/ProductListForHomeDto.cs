using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services.DTOs
{
    public class ProductListForHomeDto
    {
        public int Id { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string ProductDesc { get; set; }
        public int CategoryId { get; set; }
        public decimal UnitPrice { get; set; }
        public int CurrencyId { get; set; }
        public string CurrencyCode { get; set; }
        public string CurrencySymbol { get; set; }
        public bool AvailableForSale { get; set; }
        public string MainImagePath { get; set; }

        [Display(Name = "Kategori")]
        public string CategoryName { get; set; }

    }
}
