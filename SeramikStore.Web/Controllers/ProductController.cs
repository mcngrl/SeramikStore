using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.ViewModels;
using System.Collections.Generic;
using System.Globalization;

public class ProductController : Controller
{
    private readonly IProductService _productService;
    private readonly ICurrencyService _currencyService;
    private readonly IProductImageService _productImageService;
    private readonly ICategoryService _categoryService;

    public ProductController(IProductService productService, ICurrencyService currencyService, IProductImageService productImageService, ICategoryService categoryService)
    {
        _productService = productService;
        _currencyService = currencyService;
        _productImageService = productImageService;
        _categoryService = categoryService;
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
                            Value = x.Id.ToString(),
                            Text = $"{x.Code} - {x.Name}"
                        }).ToList(),

            Categories = _categoryService.CategoryList()
                        .Select(x => new SelectListItem
                        {
                            Value = x.Id.ToString(),
                            Text = x.Name.ToString()
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
                    Value = x.Id.ToString(),
                    Text = $"{x.Code} - {x.Name}"
                }).ToList();

            model.Categories = _categoryService.CategoryList()
            .Select(x => new SelectListItem
            {
                Value = x.Id.ToString(),
                Text = x.Name.ToString()
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
            CategoryId = model.CategoryId,
            AvailableForSale = model.AvailableForSale
        };

        _productService.InsertProduct(product);

        return RedirectToAction(nameof(Index));
    }


    [HttpGet]
    public IActionResult Edit(int id)
    {
        var product = _productService.ProductGetById(id);

        if (product == null)
        {
            return NotFound(); // veya RedirectToAction("Index")
        }

        var model = new ProductEditViewModel
        {
            Id = product.Id,
            ProductCode = product.ProductCode,
            ProductName = product.ProductName,
            ProductDesc = product.ProductDesc,
            UnitPrice = product.UnitPrice.ToString("N2", new CultureInfo("tr-TR")),
            CurrencyId = product.CurrencyId,
            CategoryId = product.CategoryId,
            AvailableForSale = product.AvailableForSale,

            Currencies = _currencyService.CurrencyList()
                .Select(x => new SelectListItem
                {
                    Value = x.Id.ToString(),
                    Text = $"{x.Code} - {x.Name}"
                })
                .ToList(),

            Categories = _categoryService.CategoryList()
                        .Select(x => new SelectListItem
                        {
                            Value = x.Id.ToString(),
                            Text = x.Name.ToString()
                        }).ToList(),
        };

        return View(model);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Edit(ProductEditViewModel model)
    {
        if (!ModelState.IsValid)
        {
            model.Currencies = _currencyService.CurrencyList()
                .Select(x => new SelectListItem
                {
                    Value = x.Id.ToString(),
                    Text = $"{x.Code} - {x.Name}"
                }).ToList();

            model.Categories = _categoryService.CategoryList()
            .Select(x => new SelectListItem
            {
                Value = x.Id.ToString(),
                Text = x.Name.ToString()
            }).ToList();

            return View(model);
        }

        var unitPrice = decimal.Parse(
            model.UnitPrice.Replace(".", "").Replace(",", "."),
            CultureInfo.InvariantCulture
        );

        var product = new Product
        {
            Id = model.Id,
            ProductCode = model.ProductCode,
            ProductName = model.ProductName,
            ProductDesc = model.ProductDesc,
            UnitPrice = unitPrice,
            CurrencyId = model.CurrencyId,
            CategoryId = model.CategoryId,
            AvailableForSale = model.AvailableForSale
        };

        _productService.UpdateProduct(product);

        return RedirectToAction("Index");
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


        List<ProductImage> images = _productImageService.GetByProductId(id);

        if (images.Any())
        {
            ModelState.AddModelError("", "Bu ürüne ait resim bulunduğu için silinemez.");

            var product = _productService.ProductGetById(id);
            return View("Delete", product);
        }
        else
        {
            _productService.DeleteProduct(id);
            TempData["Success"] = "Product deleted successfully.";
            return RedirectToAction(nameof(Index));
        }


    }






}
