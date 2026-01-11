namespace SeramikStore.Services.DTOs
{
    public class OrderDetailDto
    {
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string ProductDesc { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal LineTotal { get; set; }
        public int DisplayNo { get; set; }
    }
}