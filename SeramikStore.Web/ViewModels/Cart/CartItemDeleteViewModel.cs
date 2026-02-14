
#nullable enable

using System;
using System.ComponentModel.DataAnnotations;

namespace SeramikStore.Web.ViewModels.Cart
{
    public class CartItemDeleteViewModel
    {
        [Required]
        [Display(Name = "Id")]
        public int? Id { get; set; }

        [Required]
        [Display(Name = "ProductId")]
        public int? ProductId { get; set; }

        [Required]
        [Display(Name = "ProductCode")]
        public string? ProductCode { get; set; }

        [Required]
        [Display(Name = "ProductName")]
        public string? ProductName { get; set; }

        [Required]
        [Display(Name = "UnitPrice")]
        public decimal? UnitPrice { get; set; }

        [Required]
        [Display(Name = "Quantity")]
        public int? Quantity { get; set; }

        [Required]
        [Display(Name = "TotalAmount")]
        public decimal? TotalAmount { get; set; }

        [Display(Name = "UserId")]
        public int? UserId { get; set; }

        [Required]
        [Display(Name = "InsertDate")]
        public DateTime? InsertDate { get; set; }

        [Display(Name = "UpdateDate")]
        public DateTime? UpdateDate { get; set; }

        [Required]
        [Display(Name = "IsActive")]
        public bool? IsActive { get; set; }

        [Display(Name = "cart_id_token")]
        public string? cart_id_token { get; set; }

        [Required]
        [Display(Name = "CurrencyCode")]
        public string? CurrencyCode { get; set; }

        [Required]
        [Display(Name = "MainImagePath")]
        public string MainImagePath { get; set; }

    }
}
