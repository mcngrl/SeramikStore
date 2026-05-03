using Microsoft.AspNetCore.Mvc;
using SeramikStore.Services;
using SeramikStore.Contracts.Category;
using SeramikStore.Web.ViewModels.Category;
using System.Linq;

namespace SeramikStore.Web.Controllers
{
    public partial class CategoryController : Controller
    {

        // DETAILS
        public IActionResult Detail(int id)
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

            if (_categoryService.HasProducts(id))
            {
                TempData["Error"] = "Bu kategoriye ait ürünler bulunmaktadır. Silinemez.";
                return RedirectToAction(nameof(Index));
            }


            _categoryService.Delete(id);
            return RedirectToAction(nameof(Index));
        }
    }
}
