namespace SeramikStore.Contracts.Order
{
    public class OrderCreateResultDto
    {
        public int OrderId { get; set; }
        public string OrderStatus { get; set; }
        public string Message { get; set; }
    }

}