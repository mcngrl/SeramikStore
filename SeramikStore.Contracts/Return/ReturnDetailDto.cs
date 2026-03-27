
namespace SeramikStore.Contracts.Return
{
    public class ReturnDetailDto
    {
        public int Id { get; set; }
        public int ReturnId { get; set; }
        public int OrderDetailId { get; set; }

        public int ProductId { get; set; }
        public decimal ReturnUnitPrice { get; set; }
        public int ReturnQuantity { get; set; }

        // OrderDetail
        public int? OrderId { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string ProductDesc { get; set; }
        
        public decimal? OrderUnitPrice { get; set; }
        public int? Quantity { get; set; }
        public decimal? LineTotal { get; set; }
        public int? DisplayNo { get; set; }
        public string ImagePath { get; set; }
        public string CurrencyCode { get; set; }
    }
}
