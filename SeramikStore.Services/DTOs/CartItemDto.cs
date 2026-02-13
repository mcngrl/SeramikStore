namespace SeramikStore.Services.DTOs
{
    public class CartItemDto
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal LineTotal { get; set; }
        public string cart_id_token { get; set; }
        public string CurrencyCode { get; set; }
        public string MainImagePath { get; set; }
    } 
}