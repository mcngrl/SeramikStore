
using SkiaSharp;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("=== WebP → 200x200 Thumbnail Üretici ===\n");

        string folderPath;

        if (args.Length > 0 && Directory.Exists(args[0]))
        {
            folderPath = args[0];
        }
        else
        {
            Console.Write("Klasör yolunu girin: ");
            folderPath = Console.ReadLine()?.Trim() ?? "";
        }

        if (string.IsNullOrWhiteSpace(folderPath) ||
            !Directory.Exists(folderPath))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Geçersiz klasör yolu.");
            Console.ResetColor();
            return;
        }

        // Alt klasörler dahil edilsin mi?
        Console.Write("Alt klasörler de dahil edilsin mi? (e/h, varsayılan e): ");
        var subDirInput = Console.ReadLine()?.Trim().ToLower();

        bool includeSubDirs =
            subDirInput != "h" && subDirInput != "hayır";

        var searchOption = includeSubDirs
            ? SearchOption.AllDirectories
            : SearchOption.TopDirectoryOnly;

        // _thumb.webp olanları hariç tut
        var files = Directory
            .GetFiles(folderPath, "*.webp", searchOption)
            .Where(f => !f.EndsWith(
                "_thumb.webp",
                StringComparison.OrdinalIgnoreCase))
            .ToList();

        if (files.Count == 0)
        {
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("\nDönüştürülecek WebP dosyası bulunamadı.");
            Console.ResetColor();
            return;
        }

        Console.WriteLine(
            $"\n{files.Count} dosya bulundu. Thumbnail üretimi başlıyor...\n");

        int success = 0;
        int failed = 0;
        int skipped = 0;

        foreach (var filePath in files)
        {
            // Uzantıyı güvenli şekilde değiştir
            var thumbPath = Path.Combine(
                Path.GetDirectoryName(filePath)!,
                Path.GetFileNameWithoutExtension(filePath) + "_thumb.webp");

            // Zaten thumbnail varsa atla
            if (File.Exists(thumbPath))
            {
                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine(
                    $"[ATLA]  {Path.GetFileName(filePath)} → thumb zaten mevcut");
                Console.ResetColor();

                skipped++;
                continue;
            }

            try
            {
                // WebP dosyasını oku
                using var source = SKBitmap.Decode(filePath);

                if (source == null)
                    throw new Exception("Görüntü dosyası okunamadı.");

                // 200x200 kare için Crop hesapla
                int cropSize = Math.Min(source.Width, source.Height);

                int cropX = (source.Width - cropSize) / 2;
                int cropY = (source.Height - cropSize) / 2;

                var sourceRect = new SKRectI(
                    cropX,
                    cropY,
                    cropX + cropSize,
                    cropY + cropSize);

                // Thumbnail bitmap oluştur
                var imageInfo = new SKImageInfo(
                    200,
                    200,
                    SKColorType.Rgba8888,
                    SKAlphaType.Premul);

                using var thumbBitmap = new SKBitmap(imageInfo);

                using (var canvas = new SKCanvas(thumbBitmap))
                {
                    canvas.Clear(SKColors.Transparent);

                    canvas.DrawBitmap(
                        source,
                        sourceRect,
                        new SKRect(0, 0, 200, 200),
                        new SKSamplingOptions(
                            SKFilterMode.Linear,
                            SKMipmapMode.Linear));

                    canvas.Flush();
                }

                // WebP olarak kaydet
                using var image = SKImage.FromBitmap(thumbBitmap);

                using var encodedData = image.Encode(
                    SKEncodedImageFormat.Webp,
                    70);

                if (encodedData == null)
                    throw new Exception("WebP kodlama başarısız.");

                using (var outputStream = File.Create(thumbPath))
                {
                    encodedData.SaveTo(outputStream);
                }

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(
                    $"[OK]    {Path.GetFileName(filePath)} → {Path.GetFileName(thumbPath)}");

                Console.ResetColor();

                success++;
            }
            catch (Exception ex)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(
                    $"[HATA]  {Path.GetFileName(filePath)} → {ex.Message}");

                Console.ResetColor();

                failed++;
            }
        }

        // Özet
        Console.WriteLine("\n" + new string('─', 50));
        Console.WriteLine("Tamamlandı!");
        Console.WriteLine($"  ✔ Başarılı : {success}");
        Console.WriteLine($"  ✘ Hatalı   : {failed}");
        Console.WriteLine($"  ↷ Atlanan  : {skipped}");
        Console.WriteLine(new string('─', 50));
    }
}
