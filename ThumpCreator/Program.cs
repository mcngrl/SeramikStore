using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Formats.Webp;
using SixLabors.ImageSharp.Processing;

class Program
{
    static async Task Main(string[] args)
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
            folderPath = Console.ReadLine()?.Trim();
        }

        if (string.IsNullOrEmpty(folderPath) || !Directory.Exists(folderPath))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Geçersiz klasör yolu.");
            Console.ResetColor();
            return;
        }

        // Alt klasörler dahil edilsin mi?
        Console.Write("Alt klasörler de dahil edilsin mi? (e/h, varsayılan e): ");
        var subDirInput = Console.ReadLine()?.Trim().ToLower();
        bool includeSubDirs = subDirInput != "h" && subDirInput != "hayır";
        var searchOption = includeSubDirs ? SearchOption.AllDirectories : SearchOption.TopDirectoryOnly;

        // _thumb.webp olanları hariç tut, sadece orijinal webp'leri al
        var files = Directory
            .GetFiles(folderPath, "*.webp", searchOption)
            .Where(f => !f.EndsWith("_thumb.webp", StringComparison.OrdinalIgnoreCase))
            .ToList();

        if (files.Count == 0)
        {
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("\nDönüştürülecek WebP dosyası bulunamadı.");
            Console.ResetColor();
            return;
        }

        Console.WriteLine($"\n{files.Count} dosya bulundu. Thumbnail üretimi başlıyor...\n");

        int success = 0, failed = 0, skipped = 0;

        var encoder = new WebpEncoder { Quality = 70 };

        foreach (var filePath in files)
        {
            var thumbPath = filePath.Replace(".webp", "_thumb.webp");

            // Zaten thumb varsa atla
            if (File.Exists(thumbPath))
            {
                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine($"[ATLA]  {Path.GetFileName(filePath)} → thumb zaten mevcut");
                Console.ResetColor();
                skipped++;
                continue;
            }

            try
            {
                using var img = await Image.LoadAsync(filePath);
                using var thumb = img.Clone(x => x.Resize(new ResizeOptions
                {
                    Size = new Size(200, 200),
                    Mode = ResizeMode.Crop
                }));
                await thumb.SaveAsWebpAsync(thumbPath, encoder);

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine($"[OK]    {Path.GetFileName(filePath)} → {Path.GetFileName(thumbPath)}");
                Console.ResetColor();
                success++;
            }
            catch (Exception ex)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"[HATA]  {Path.GetFileName(filePath)} → {ex.Message}");
                Console.ResetColor();
                failed++;
            }
        }

        Console.WriteLine("\n" + new string('─', 50));
        Console.WriteLine("Tamamlandı!");
        Console.WriteLine($"  ✔ Başarılı : {success}");
        Console.WriteLine($"  ✘ Hatalı   : {failed}");
        Console.WriteLine($"  ↷ Atlanan  : {skipped}");
        Console.WriteLine(new string('─', 50));
    }
}