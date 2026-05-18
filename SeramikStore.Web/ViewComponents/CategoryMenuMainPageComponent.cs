using Microsoft.AspNetCore.Mvc;
using SeramikStore.Contracts.Category;
using SeramikStore.Entities;
using SeramikStore.Services;

namespace SeramikStore.Web.ViewComponents
{
    public class CategoryMenuMainPage : ViewComponent
    {
        private readonly ICategoryService _categoryService;

        public CategoryMenuMainPage(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        public IViewComponentResult Invoke(int selectedCategoryId = 0)
        {
            var categories = _categoryService.List();
            CategoryNavigationDto c = new CategoryNavigationDto
            {
                List = categories,
                SelectedCategoryId = selectedCategoryId

            };

            return View(c);
        }
    }
}
