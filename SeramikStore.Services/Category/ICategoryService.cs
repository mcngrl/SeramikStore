using SeramikStore.Entities;

namespace SeramikStore.Services
{
    public partial interface ICategoryService
    {
        List<Category> XCategoryList();
        Category XCategoryGetById(int id);
        int XInsertCategory(Category category);
        int XUpdateCategory(Category category);
        int XDeleteCategory(int id);
    }
}