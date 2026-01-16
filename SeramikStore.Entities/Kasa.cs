using System;

namespace SeramikStore.Entities
{
    public class Kasa
    {
        // Identity
        public int Id { get; set; }
        public int ProductId { get; set; }
        public required string ProductCode { get; set; }
        public required string ProductName { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal TotalAmount { get; set; }
        public int UserId { get; set; }
        public DateTime InsertDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public bool IsActive { get; set; }
    }
}
