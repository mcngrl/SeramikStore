using SeramikStore.Entities;

public interface IProductService
{
    List<Product> ProductList();
    Product ProductGetById(int id);
}
