using SeramikStore.Entities;

public interface ICategoryService
{
    List<Category> CategoryList();
    Category CategoryGetById(int id);
    int InsertCategory(Category category);
    int UpdateCategory(Category category);
    int DeleteCategory(int id);
}
