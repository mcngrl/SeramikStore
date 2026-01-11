namespace SeramikStore.Services.DTOs
{
    public class OrderListItemDto
    {
        public int OrderId { get; set; }
        public DateTime OrderDate { get; set; }
        public string OrderStatus { get; set; }
        public string PaymentType { get; set; }
        public decimal ProductTotal { get; set; }
        public decimal CargoAmount { get; set; }
        public decimal GrandTotal { get; set; }
    }
}
