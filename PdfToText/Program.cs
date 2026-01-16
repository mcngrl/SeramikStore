using iTextSharp.text.pdf;
using iTextSharp.text.pdf.parser;
using System;
using System.IO;
using System.Text;
using static System.Net.Mime.MediaTypeNames;
using Path = System.IO.Path;

class Program
{

    static void Main()
   {

        string prt = "Part4";
        string pdfFolder = @"D:\Root\CVInceleme\PDF\" + prt;
        string outputTxtPath = @"D:\Root\CVInceleme\PDF\" + prt + ".txt";

        Directory.CreateDirectory(Path.GetDirectoryName(outputTxtPath));

        StringBuilder allText = new StringBuilder();

        foreach (var pdfPath in Directory.GetFiles(pdfFolder, "*.pdf"))
        {
            string fileName = Path.GetFileName(pdfPath);

            allText.AppendLine("==================================================");
            allText.AppendLine($"PDF DOSYASI: {fileName}");
            allText.AppendLine("==================================================");
            allText.AppendLine();

            using (PdfReader reader = new PdfReader(pdfPath))
            {
                for (int i = 1; i <= reader.NumberOfPages; i++)
                {
                    string pageText = PdfTextExtractor.GetTextFromPage(
                        reader,
                        i,
                        new SimpleTextExtractionStrategy()
                    );

                    allText.AppendLine(pageText);
                }
            }

            allText.AppendLine();
            allText.AppendLine();
            Console.WriteLine($"{fileName} eklendi");
        }

        File.WriteAllText(outputTxtPath, allText.ToString(), Encoding.UTF8);

        Console.WriteLine("Tüm PDF’ler tek TXT dosyasında birleştirildi.");
        Console.ReadLine();
    }
    static void Main22()
    {
        string pdfFolder = @"D:\Root\CVInceleme\PDF";
        string txtFolder = @"D:\Root\CVInceleme\TXT";

        Directory.CreateDirectory(txtFolder);

        foreach (var pdfPath in Directory.GetFiles(pdfFolder, "*.pdf"))
        {
            string fileName = Path.GetFileNameWithoutExtension(pdfPath);
            string txtPath = Path.Combine(txtFolder, fileName + ".txt");

            StringBuilder text = new StringBuilder();

            using (PdfReader reader = new PdfReader(pdfPath))
            {
                for (int i = 1; i <= reader.NumberOfPages; i++)
                {
                    string pageText = PdfTextExtractor.GetTextFromPage(
                        reader,
                        i,
                        new SimpleTextExtractionStrategy()
                    );

                    text.AppendLine(pageText);
                }
            }

            File.WriteAllText(txtPath, text.ToString(), Encoding.UTF8);
            Console.WriteLine($"{fileName}.pdf -> TXT oluşturuldu");
        }

        Console.WriteLine("Tüm işlemler tamamlandı.");
        Console.ReadLine();
    }
}
