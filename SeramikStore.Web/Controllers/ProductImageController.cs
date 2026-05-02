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

    // 📤 Upload
    //[HttpPost]
    //[ValidateAntiForgeryToken]
    //public IActionResult Upload(int productId, IFormFile image, bool isMain = false)
    //{
    //    if (image == null || image.Length == 0)
    //    {
    //        TempData["Error"] = "Lütfen bir resim seçiniz.";
    //        return RedirectToAction("Index", new { productId });
    //    }

    //    // uploads/products/{productId}
    //    var uploadFolder = Path.Combine(
    //        _env.WebRootPath,
    //        "uploads",
    //        "products",
    //        productId.ToString()
    //    );

    //    if (!Directory.Exists(uploadFolder))
    //        Directory.CreateDirectory(uploadFolder);

    //    var fileName = Guid.NewGuid() + Path.GetExtension(image.FileName);
    //    var filePath = Path.Combine(uploadFolder, fileName);

    //    using (var stream = new FileStream(filePath, FileMode.Create))
    //    {
    //        image.CopyTo(stream);
    //    }

    //    var imagePath = $"/uploads/products/{productId}/{fileName}";

    //    var productImage = new ProductImage
    //    {
    //        ProductId = productId,
    //        ImagePath = imagePath,
    //        IsMain = isMain,
    //        DisplayOrder = 0
    //    };

    //    _productImageService.Insert(productImage);

    //    if (isMain)
    //    {
    //        _productImageService.SetMainImage(productId, productImage.Id);
    //    }

    //    TempData["Success"] = "Resim başarıyla yüklendi.";
    //    return RedirectToAction("Index", new { productId });
    //}

    // ⭐ Ana resim yap
    [HttpPost]


    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Upload(int productId, IFormFile image, bool isMain = false)
    {
        if (image == null || image.Length == 0)
        {
            TempData["Error"] = "Lütfen bir resim seçiniz.";
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

        var baseName = Guid.NewGuid().ToString("N");

        // Dosya yolları
        var fullFileName = baseName + ".webp";
        var thumbFileName = baseName + "_thumb.webp";
        var fullPath = Path.Combine(uploadFolder, fullFileName);
        var thumbPath = Path.Combine(uploadFolder, thumbFileName);
        var font = SystemFonts.CreateFont("Arial", 36, FontStyle.Bold);

        using (var stream = image.OpenReadStream())
        using (var img = await SixLabors.ImageSharp.Image.LoadAsync(stream))
        {
            // EXIF yönünü düzelt
            img.Mutate(x => x.AutoOrient());

            // 1) Orijinal boyut (1200'den büyükse küçült, küçükse dokunma)
            using var fullImg = img.Clone(x => x
                .Resize(new ResizeOptions
                {
                    Size = new Size(1200, 0),
                    Mode = ResizeMode.Max
                })
                //.DrawText(_company.Name, font, Color.Black, new PointF(25, 25))
                //.DrawText(_company.Name, font, Color.White, new PointF(23, 23))
            );

            await fullImg.SaveAsWebpAsync(fullPath, new WebpEncoder { Quality = 82 });

            // 2) Thumbnail 200x200 (orantılı kırparak)
            using var thumbImg = img.Clone(x => x.Resize(new ResizeOptions
            {
                Size = new Size(200, 200),
                Mode = ResizeMode.Crop  // ortadan kırpar, oranı zorlar
            }));
            await thumbImg.SaveAsWebpAsync(thumbPath, new WebpEncoder { Quality = 70 });
        }

        var imagePath = $"/uploads/products/{productId}/{fullFileName}";
        var thumbImagePath = $"/uploads/products/{productId}/{thumbFileName}";

        var productImage = new ProductImage
        {
            ProductId = productId,
            ImagePath = imagePath,
            IsMain = isMain,
            DisplayOrder = 0
        };

        _productImageService.Insert(productImage);

        if (isMain)
            _productImageService.SetMainImage(productId, productImage.Id);

        TempData["Success"] = "Resim başarıyla yüklendi.";
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
