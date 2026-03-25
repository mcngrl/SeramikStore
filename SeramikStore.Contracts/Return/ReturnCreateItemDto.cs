
namespace SeramikStore.Contracts.Return
{
    public class ReturnCreateItemDto
    {
        public int OrderId { get; set; }
        public int OrderDetailId { get; set; }
        public int ProductId { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string ProductDesc { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal LineTotal { get; set; }
        public int DisplayNo { get; set; }
        public string ImagePath { get; set; }

        public int LineReturnQuantityTotal { get; set; }
        public decimal LineReturnPriceTotal { get; set; }

        public int AvaliableQuatityForReturn { get; set; }
        public string CurrencyCode { get; set; }

        // kullanıcı girecek
        public int ReturnQuantity { get; set; }

    }
}
