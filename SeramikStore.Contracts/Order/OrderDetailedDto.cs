
namespace SeramikStore.Contracts.Order
{
    public class OrderDetailedDto
    {
        // Header
        public int Id { get; set; }
        public DateTime OrderDate { get; set; }
        public string OrderStatus { get; set; }
        public int OrderStatusCode { get; set; }
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

        public List<OrderStatusHistoryDto> StatusHistoryLog { get; set; } = new();

        public List<StatusOptionDto> NextStatusesForUpdate { get; set; } = new();

        public List<StatusOptionDto> AllStatuses { get; set; }  = new ();

    }
}

