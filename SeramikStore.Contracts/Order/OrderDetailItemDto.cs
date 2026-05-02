namespace SeramikStore.Contracts.Order
{
    public class OrderDetailItemDto
    {
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string ProductDesc { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal LineTotal { get; set; }
        public int DisplayNo { get; set; }
        public string ImagePath { get; set; }

        public string ImageThumbPath
        {
            get
            {
                if (string.IsNullOrEmpty(ImagePath))
                    return null;

                var extension = Path.GetExtension(ImagePath);
                var withoutExt = ImagePath.Replace(extension, "");

                return $"{withoutExt}_thumb{extension}";
            }
        }
    }
}