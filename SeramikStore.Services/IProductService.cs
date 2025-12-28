using SeramikStore.Entities;


    public interface IProductService
    {
        List<Product> ProductList();
        Product ProductGetById(int id);
        int InsertProduct(Product product);
        int UpdateProduct(Product product);
        int DeleteProduct(int id);
    }

