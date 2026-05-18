using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.Options;
using SixLabors.Fonts;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Drawing.Processing;
using SixLabors.ImageSharp.Formats.Webp;
using SixLabors.ImageSharp.Processing;
using static System.Net.Mime.MediaTypeNames;

public class ProductImageController : Controller
{
    private readonly IProductImageService _productImageService;
    private readonly IWebHostEnvironment _env;
    private readonly CompanyOptions _company;

    public ProductImageController(
        IProductImageService productImageService,
        IWebHostEnvironment env,
        IOptions<CompanyOptions> companyOptions)
    {
        _productImageService = productImageService;
        _env = env;
        _company = companyOptions.Value;
    }

    // 📋 Ürüne ait resimler
    public IActionResult Index(int productId)
    {
        ViewBag.ProductId = productId;
        var images = _productImageService.GetByProductId(productId);
        return View(images);
    }
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Upload(int productId, List<IFormFile> images, bool isMain = false)
    {
        if (images == null || images.Count == 0)
        {
            TempData["Error"] = "Lütfen en az bir resim seçiniz.";
            return RedirectToAction("Index", new { productId });
        }

        var uploadFolder = Path.Combine(
            _env.WebRootPath,
            "uploads",
            "products",
            productId.ToString()
        );

        if (!Directory.Exists(uploadFolder))
            Directory.CreateDirectory(uploadFolder);

        bool firstImage = true;

        foreach (var image in images)
        {
            if (image == null || image.Length == 0) continue;

            var baseName = Guid.NewGuid().ToString("N");
            var fullFileName = baseName + ".webp";
            var thumbFileName = baseName + "_thumb.webp";
            var fullPath = Path.Combine(uploadFolder, fullFileName);
            var thumbPath = Path.Combine(uploadFolder, thumbFileName);

            using (var stream = image.OpenReadStream())
            using (var img = await SixLabors.ImageSharp.Image.LoadAsync(stream))
            {
                img.Mutate(x => x.AutoOrient());

                using var fullImg = img.Clone(x => x.Resize(new ResizeOptions
                {
                    Size = new Size(1200, 0),
                    Mode = ResizeMode.Max
                }));
                await fullImg.SaveAsWebpAsync(fullPath, new WebpEncoder { Quality = 82 });

                using var thumbImg = img.Clone(x => x.Resize(new ResizeOptions
                {
                    Size = new Size(200, 200),
                    Mode = ResizeMode.Crop
                }));
                await thumbImg.SaveAsWebpAsync(thumbPath, new WebpEncoder { Quality = 70 });
            }

            var productImage = new ProductImage
            {
                ProductId = productId,
                ImagePath = $"/uploads/products/{productId}/{fullFileName}",
                IsMain = isMain && firstImage, // sadece ilk resim ana olur
                DisplayOrder = 0
            };

            _productImageService.Insert(productImage);

            if (isMain && firstImage)
                _productImageService.SetMainImage(productId, productImage.Id);

            firstImage = false;
        }

        TempData["Success"] = $"{images.Count} resim başarıyla yüklendi.";
        return RedirectToAction("Index", new { productId });
    }


    public IActionResult SetMain(int productId, int imageId)
    {
        _productImageService.SetMainImage(productId, imageId);
        return RedirectToAction("Index", new { productId });
    }

    // 🔢 Sıra güncelle
    [HttpPost]
    public IActionResult UpdateOrder(int id, int displayOrder, int productId)
    {
        var image = new ProductImage
        {
            Id = id,
            DisplayOrder = displayOrder
        };

        _productImageService.Update(image);
        return RedirectToAction("Index", new { productId });
    }

    // ❌ Sil
    [HttpPost]
    public IActionResult Delete(int id, int productId)
    {

        _productImageService.Delete(id);
        TempData["Success"] = "Resim silindi.";
        return RedirectToAction("Index", new { productId });
    }
}
