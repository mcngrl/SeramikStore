using SeramikStore.Entities;
using SeramikStore.Services.DTOs;


    public interface IProductService
    {
        List<Product> ProductList();

        List<ProductListForAdminDto> ProductListForAdmin();


        Product ProductGetById(int id);
        int InsertProduct(Product product);
        int UpdateProduct(Product product);
        int DeleteProduct(int id);
    }

