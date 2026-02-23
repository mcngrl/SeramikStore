
namespace SeramikStore.Contracts.Order
{
    public class OrderStatusHistoryDto
    {
        public int OrderStatusCode { get; set; }
        public DateTime IslemTarihi { get; set; }
        public string Aciklama { get; set; }
    }
}
