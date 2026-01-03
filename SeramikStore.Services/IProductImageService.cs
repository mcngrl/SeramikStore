using SeramikStore.Entities;

public interface IProductImageService
{
    int Insert(ProductImage image);
    int Update(ProductImage image);
    int Delete(int id);
    List<ProductImage> GetByProductId(int productId);
    void SetMainImage(int productId, int imageId);
}
