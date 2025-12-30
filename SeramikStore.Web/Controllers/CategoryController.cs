using Microsoft.AspNetCore.Mvc;
using SeramikStore.Entities;
using SeramikStore.Services;

namespace SeramikStore.Web.Controllers
{
    public class CategoryController : Controller
    {
        private readonly ICategoryService _categoryService;

        public CategoryController(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        // 🔹 LIST
        public IActionResult Index()
        {
            var categories = _categoryService.CategoryList();
            return View(categories);
        }

        // 🔹 CREATE (GET)
        [HttpGet]
        public IActionResult Create()
        {
            return View(new Category { IsActive = true });
        }

        // 🔹 CREATE (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Category category)
        {
            if (!ModelState.IsValid)
                return View(category);

            _categoryService.InsertCategory(category);
            TempData["Success"] = "Kategori başarıyla eklendi.";
            return RedirectToAction(nameof(Index));
        }

        // 🔹 EDIT (GET)
        [HttpGet]
        public IActionResult Edit(int id)
        {
            var category = _categoryService.CategoryGetById(id);
            if (category == null)
                return NotFound();

            return View(category);
        }

        // 🔹 EDIT (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(Category category)
        {
            if (!ModelState.IsValid)
                return View(category);

            _categoryService.UpdateCategory(category);
            TempData["Success"] = "Kategori güncellendi.";
            return RedirectToAction(nameof(Index));
        }

        // 🔹 DELETE (GET)
        [HttpGet]
        public IActionResult Delete(int id)
        {
            var category = _categoryService.CategoryGetById(id);
            if (category == null)
                return NotFound();

            return View(category);
        }

        // 🔹 DELETE (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            _categoryService.DeleteCategory(id);
            TempData["Success"] = "Kategori silindi.";
            return RedirectToAction(nameof(Index));
        }
    }
}
