namespace SeramikStore.Services.DTOs
{
    public class OrderDetailedDto
    {
        // Header
        public int Id { get; set; }
        public DateTime OrderDate { get; set; }
        public string OrderStatus { get; set; }
        public decimal CargoAmount { get; set; }
        public int UserId { get; set; }
        public string CurrencyCode { get; set; }
        public decimal ProductTotal { get; set; }
        public decimal GrandTotal { get; set; }
        public string KargoSirketi { get; set; }
        public DateTime? KargoyaVerilmeTarihi { get; set; }
        public string KargoTakipNo { get; set; }

        // Child Collections
        public List<OrderDetailItemDto> Items { get; set; } = new();
        public OrderAddressDto Address { get; set; }
        public List<OrderStatusHistoryDto> StatusHistory { get; set; } = new();
    }


}