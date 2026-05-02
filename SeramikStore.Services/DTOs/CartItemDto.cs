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
        public int? UserId { get; set; }

        public int StockAmount { get; set; }
        public string cart_id_token { get; set; }
        public string CurrencyCode { get; set; }
        public string MainImagePath { get; set; }

        public string MainImageThumbPath
        {
            get
            {
                if (string.IsNullOrEmpty(MainImagePath))
                    return null;

                var extension = Path.GetExtension(MainImagePath);
                var withoutExt = MainImagePath.Replace(extension, "");

                return $"{withoutExt}_thumb{extension}";
            }
        }
    } 
}