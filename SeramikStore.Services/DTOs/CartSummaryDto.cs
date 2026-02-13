namespace SeramikStore.Services.DTOs
{
    public class CartSummaryDto
    {
        public decimal TotalAmount { get; set; }
        public decimal CargoAmount { get; set; }
        public decimal GrandTotal { get; set; }
        public string CurrencyCode { get; set; }
    }

}

