using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services.DTOs
{
    public class ProductListForAdminDto
    {
        public int Id { get; set; }

        [Display(Name = "Ürün Kodu")]
        public string ProductCode { get; set; }

        [Display(Name = "Ürün Adı")]
        public string ProductName { get; set; }

        [Display(Name = "Açıklama")]
        public string ProductDesc { get; set; }

        [Display(Name = "Kategori")]
        public string CategoryName { get; set; }

        [Display(Name = "Birim Fiyat")]
        public decimal UnitPrice { get; set; }


        [Display(Name = "Para Birimi Kodu")]
        public string CurrencyCode { get; set; }

        [Display(Name = "Para Birimi Sembolü")]
        public string CurrencySymbol { get; set; }
        
        [Display(Name = "Satış")]
        public bool AvailableForSale { get; set; }

        [Display(Name = "Ana Resim")]
        public string MainImagePath { get; set; }

        [Display(Name = "Resim Sayısı")]
        public int ImageCount { get; set; }

    }
}
