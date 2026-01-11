namespace SeramikStore.Services.DTOs
{
    public class OrderInfoDto
    {
        // Header
        public int OrderId { get; set; }
        public DateTime OrderDate { get; set; }
        public string OrderStatus { get; set; }
        public decimal CargoAmount { get; set; }
        public string PaymentType { get; set; }
        public int UserId { get; set; }
        public int AddressId { get; set; }

        public decimal ProductTotal { get; set; }
        public decimal GrandTotal { get; set; }

        // Detail
        public List<OrderDetailDto> Details { get; set; } = new();
    }


}