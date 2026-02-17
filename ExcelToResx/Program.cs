using ClosedXML.Excel;
using System.Text;
using System.Diagnostics;

string excelPath = @"C:\temp\veri.xlsx";

string outputPathTR = @"C:\temp\output_tr.txt";
string outputPathEN = @"C:\temp\output_en.txt";

var sbTR = new StringBuilder();
var sbEN = new StringBuilder();

using (var workbook = new XLWorkbook(excelPath))
{
    var worksheet = workbook.Worksheet(1);

    var rows = worksheet.RangeUsed().RowsUsed().Skip(1); // header atla

    foreach (var row in rows)
    {
        string key = row.Cell(1).GetString();
        string valueTR = row.Cell(2).GetString();
        string valueEN = row.Cell(3).GetString();

        // TR
        sbTR.AppendLine($@" <data name=""{key}"" xml:space=""preserve"">");
        sbTR.AppendLine($@"   <value>{valueTR}</value>");
        sbTR.AppendLine($@" </data>");

        // EN
        sbEN.AppendLine($@" <data name=""{key}"" xml:space=""preserve"">");
        sbEN.AppendLine($@"   <value>{valueEN}</value>");
        sbEN.AppendLine($@" </data>");
    }
}

// Dosyaları yaz
File.WriteAllText(outputPathTR, sbTR.ToString(), Encoding.UTF8);
File.WriteAllText(outputPathEN, sbEN.ToString(), Encoding.UTF8);

Console.WriteLine("Dosyalar oluşturuldu:");
Console.WriteLine(outputPathTR);
Console.WriteLine(outputPathEN);

// Notepad ile aç
Process.Start(new ProcessStartInfo("notepad.exe", outputPathTR) { UseShellExecute = true });
Process.Start(new ProcessStartInfo("notepad.exe", outputPathEN) { UseShellExecute = true });

Console.ReadLine();
