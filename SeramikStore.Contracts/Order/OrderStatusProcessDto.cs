
namespace SeramikStore.Contracts.Order
{
    public class OrderStatusProcessDto
    {
        public int RowOrderNo { get; set; }
        public string Faz { get; set; }
        public int OrderStatusCode { get; set; }
        public DateTime? IslemTarihi { get; set; }
        public string Aciklama { get; set; }
        public string? UserNameSurname { get; set; }
        public bool isLast { get; set; }
        public bool isCompleted { get; set; }
    }
}
