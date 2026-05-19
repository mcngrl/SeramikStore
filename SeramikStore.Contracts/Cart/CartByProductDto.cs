using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Cart
{
    // SeramikStore.Entities/CartByProductDto.cs
    public class CartByProductDto
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductCode { get; set; }
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal TotalAmount { get; set; }
        public string CurrencyCode { get; set; }
        public DateTime InsertDate { get; set; }
        public bool IsActive { get; set; }
        public string CartIdToken { get; set; }
        public int? UserId { get; set; }
        public string KullaniciAdi { get; set; }  // SP'den geliyor
        public string Email { get; set; }
    }
}
