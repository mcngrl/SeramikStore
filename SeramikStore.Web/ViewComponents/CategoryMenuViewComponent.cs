using SeramikStore.Entities;
using SeramikStore.Services;
using Microsoft.AspNetCore.Mvc;

namespace SeramikStore.Web.ViewComponents
{
    public class CategoryMenuViewComponent : ViewComponent
    {
        private readonly ICategoryService _categoryService;

        public CategoryMenuViewComponent(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        public IViewComponentResult Invoke()
        {
            var categories = _categoryService.List();
            return View(categories);
        }
    }
}
