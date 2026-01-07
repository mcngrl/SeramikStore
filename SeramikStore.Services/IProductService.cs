using SeramikStore.Entities;
using SeramikStore.Services.DTOs;


    public interface IProductService
    {
        List<ProductListForHomeDto> ProductList();

        List<ProductListForAdminDto> ProductListForAdmin();

        ProductDetailDto ProductGetById(int id);

        int InsertProduct(Product product);
        int UpdateProduct(Product product);
        int DeleteProduct(int id);

        void UpdateDisplayOrder(List<ProductOrderDto> list);
}

