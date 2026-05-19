using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Order
{
    // SeramikStore.Entities/OrderByProductDto.cs
    public class OrderByProductDto
    {
        public int OrderDetailId { get; set; }
        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal LineTotal { get; set; }
        public DateTime OrderDate { get; set; }
        public string CurrencyCode { get; set; }
        public int UserId { get; set; }
        public string KullaniciAdi { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
    }
}
