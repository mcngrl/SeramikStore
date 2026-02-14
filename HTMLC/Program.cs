using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        string solid = @"C:\Users\sony\Downloads\fontawesome-free-7.2.0-web\fontawesome-free-7.2.0-web\svgs-full\solid";
        string regular = @"C:\Users\sony\Downloads\fontawesome-free-7.2.0-web\fontawesome-free-7.2.0-web\svgs-full\regular";
        string brands = @"C:\Users\sony\Downloads\fontawesome-free-7.2.0-web\fontawesome-free-7.2.0-web\svgs-full\brands";

        var allIcons = new List<(string Style, string Name)>();

        ReadFolder(solid, "fa-solid", allIcons);
        ReadFolder(regular, "fa-regular", allIcons);
        ReadFolder(brands, "fa-brands", allIcons);

        string outputPath = "all-icons.html";

        var html = new StringBuilder();

        html.Append(@"
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<title>Font Awesome All Icons</title>
<link href='/lib/fontawesome/css/all.min.css' rel='stylesheet'>
<style>
body { font-family: Arial; padding:20px; }
.grid {
    display: grid;
    grid-template-columns: repeat(9, 1fr);
    gap: 20px;
}
.icon-box {
    text-align:center;
    padding:15px;
    border:1px solid #ddd;
    border-radius:8px;
}
.icon-box i {
    font-size:32px;
    margin-bottom:10px;
}
.icon-name {
    font-size:12px;
    word-break: break-all;
}
</style>
</head>
<body>
<h2>Font Awesome All Icons</h2>
<div class='grid'>
");

        foreach (var icon in allIcons.OrderBy(x => x.Name))
        {
            html.Append($@"
<div class='icon-box'>
    <i class='{icon.Style} fa-{icon.Name}'></i>
    <div class='icon-name'>{icon.Style} fa-{icon.Name}</div>
</div>");
        }

        html.Append(@"
</div>
</body>
</html>");

        File.WriteAllText(outputPath, html.ToString());

        Console.WriteLine("HTML oluşturuldu: " + outputPath);
        Console.ReadLine();
    }

    static void ReadFolder(string path, string style, List<(string Style, string Name)> list)
    {
        if (!Directory.Exists(path)) return;

        var files = Directory.GetFiles(path, "*.svg");

        foreach (var file in files)
        {
            string name = Path.GetFileNameWithoutExtension(file);
            list.Add((style, name));
        }
    }
}
