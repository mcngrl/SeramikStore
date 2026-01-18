using Microsoft.AspNetCore.Mvc;
using SeramikStore.Services;
using SeramikStore.Contracts.Category;
using SeramikStore.Web.ViewModels.Category;
using System.Linq;

namespace SeramikStore.Web.Controllers
{
    public class CategoryController : Controller
    {
        private readonly ICategoryService _categoryService;

        public CategoryController(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        // LIST
        public IActionResult Index()
        {
            var list = _categoryService.List();

            var vmList = list.Select(x => new CategoryListViewModel
            {
                Id = x.Id,
                Name = x.Name,
                IsActive = x.IsActive
            }).ToList();

            return View(vmList);
        }

        // DETAILS
        public IActionResult Details(int id)
        {
            var dto = _categoryService.GetById(id);
            if (dto == null)
                return NotFound();

            var vm = new CategoryViewModel
            {
                Id = dto.Id,
                Name = dto.Name,
                IsActive = dto.IsActive
            };

            return View(vm);
        }

        // CREATE (GET)
        public IActionResult Create()
        {
            return View(new CategoryCreateViewModel());
        }

        // CREATE (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(CategoryCreateViewModel vm)
        {
            if (!ModelState.IsValid)
                return View(vm);

            var dto = new CategoryCreateDto
            {
                Name = vm.Name
            };

            _categoryService.Create(dto);
            return RedirectToAction(nameof(Index));
        }

        // UPDATE (GET)
        public IActionResult Edit(int id)
        {
            var dto = _categoryService.GetById(id);
            if (dto == null)
                return NotFound();

            var vm = new CategoryUpdateViewModel
            {
                Id = dto.Id,
                Name = dto.Name,
                IsActive = dto.IsActive
            };

            return View(vm);
        }

        // UPDATE (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(CategoryUpdateViewModel vm)
        {
            if (!ModelState.IsValid)
                return View(vm);

            var dto = new CategoryUpdateDto
            {
                Id = vm.Id,
                Name = vm.Name,
                IsActive = vm.IsActive
            };

            _categoryService.Update(dto);
            return RedirectToAction(nameof(Index));
        }

        // DELETE (GET)
        public IActionResult Delete(int id)
        {
            var dto = _categoryService.GetById(id);
            if (dto == null)
                return NotFound();

            var vm = new CategoryViewModel
            {
                Id = dto.Id,
                Name = dto.Name,
                IsActive = dto.IsActive
            };

            return View(vm);
        }

        // DELETE (POST)
        [HttpPost, ActionName("DeleteConfirmed")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            _categoryService.Delete(id);
            return RedirectToAction(nameof(Index));
        }
    }
}
