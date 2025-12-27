using Microsoft.AspNetCore.Mvc;
using SeramikStore.Entities;
using SeramikStore.Services;

namespace SeramikStore.Web.Controllers
{
    public class CurrencyController : Controller
    {
        private readonly ICurrencyService _currencyService;

        public CurrencyController(ICurrencyService currencyService)
        {
            _currencyService = currencyService;
        }

        // LIST
        public IActionResult Index()
        {
            var currencies = _currencyService.CurrencyList();
            return View(currencies);
        }

        // CREATE - GET
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Currency currency)
        {
            if (!ModelState.IsValid)
                return View(currency);

            _currencyService.InsertCurrency(currency);
            return RedirectToAction(nameof(Index));
        }

        [HttpGet]
        public IActionResult Edit(int id)
        {
            var currency = _currencyService.GetById(id);

            if (currency == null)
                return NotFound();

            return View(currency);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(Currency currency)
        {
            if (!ModelState.IsValid)
                return View(currency);

            _currencyService.UpdateCurrency(currency);
            return RedirectToAction(nameof(Index));
        }


        [HttpGet]
        public IActionResult Delete(int id)
        {
            var currency = _currencyService.GetById(id);

            if (currency == null)
                return NotFound();

            // Default currency silinmesin (opsiyonel ama önerilir)
            if (currency.IsDefault)
            {
                TempData["Error"] = "Default currency cannot be deleted.";
                return RedirectToAction(nameof(Index));
            }

            return View(currency);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int currencyId)
        {
            var currency = _currencyService.GetById(currencyId);

            if (currency == null)
                return NotFound();

            if (currency.IsDefault)
            {
                TempData["Error"] = "Default currency cannot be deleted.";
                return RedirectToAction(nameof(Index));
            }

            _currencyService.DeleteCurrency(currencyId);

            TempData["Success"] = "Currency deleted successfully.";
            return RedirectToAction(nameof(Index));
        }



    }
}
