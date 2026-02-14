namespace SeramikStore.Web.ViewModels
{
    public class CartItem
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string ProductDesc { get; set; }

        public int CategoryId { get; set; }
        public decimal UnitPrice { get; set; }

        public int Quantity { get; set; }
        public decimal LineTotal { get; set; }
        public string CurrencyCode { get; set; }
    }
}
