using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using SeramikStore.Entities;
using SeramikStore.Services;

public class ProductController : Controller
{
    private readonly IProductService _productService;
    private readonly ICurrencyService _currencyService;

    public ProductController(IProductService productService, ICurrencyService currencyService)
    {
        _productService = productService;
        _currencyService = currencyService;
    }

    public IActionResult Index()
    {
        return View(_productService.ProductList());
    }

    [HttpGet]
    public IActionResult Create()
    {
        var currencies = _currencyService.CurrencyList();

        ViewBag.Currencies = currencies.Select(x => new SelectListItem
        {
            Value = x.Code,
            Text = $"{x.Code} - {x.Name}"
        }).ToList();

        return View();
    }


    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Create(Product product)
    {
        if (!ModelState.IsValid)
            return View(product);

        _productService.InsertProduct(product);
        TempData["Success"] = "Ürün eklendi";
        return RedirectToAction(nameof(Index));
    }

    [HttpGet]
    public IActionResult Edit(int id)
    {
        return View(_productService.ProductGetById(id));
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Edit(Product product)
    {
        if (!ModelState.IsValid)
            return View(product);

        _productService.UpdateProduct(product);
        TempData["Success"] = "Ürün güncellendi";
        return RedirectToAction(nameof(Index));
    }

    [HttpGet]
    public IActionResult Delete(int id)
    {
        var product = _productService.ProductGetById(id);
        if (product == null)
            return NotFound();

        return View(product);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult DeleteConfirmed(int id)
    {
        _productService.DeleteProduct(id);
        TempData["Success"] = "Product deleted successfully.";
        return RedirectToAction(nameof(Index));
    }
}
