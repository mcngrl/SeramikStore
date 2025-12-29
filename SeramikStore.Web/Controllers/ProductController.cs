using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.ViewModels;
using System.Globalization;

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
        
        return View(_productService.ProductListForAdmin());
    }

    [HttpGet]
    public IActionResult Create()
    {
        var model = new ProductCreateViewModel
        {
           // Product = new Product(),
            Currencies = _currencyService.CurrencyList()
                        .Select(x => new SelectListItem
                        {
                            Value = x.CurrencyId.ToString(),
                            Text = $"{x.Code} - {x.Name}"
                        }).ToList(),
        };

        return View(model);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Create(ProductCreateViewModel model)
    {
        if (!ModelState.IsValid)
        {
            model.Currencies = _currencyService.CurrencyList()
                .Select(x => new SelectListItem
                {
                    Value = x.CurrencyId.ToString(),
                    Text = $"{x.Code} - {x.Name}"
                }).ToList();

            return View(model);
        }

    
        var unitPrice = decimal.Parse(
            model.UnitPrice.Replace(".", "").Replace(",", "."),
            CultureInfo.InvariantCulture);

        var product = new Product
        {
            ProductCode = model.ProductCode,
            ProductName = model.ProductName,
            ProductDesc = model.ProductDesc,
            UnitPrice = unitPrice,
            CurrencyId = model.CurrencyId,
            AvailableForSale = model.AvailableForSale
        };

        _productService.InsertProduct(product);

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
