namespace SeramikStore.Entities
{
    public class ProductImage
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public string ImagePath { get; set; }

        // DB'ye yazılmaz, her zaman ImagePath'ten türetilir
        public string ThumbPath
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

        public bool IsMain { get; set; }
        public int DisplayOrder { get; set; }
    }
}
