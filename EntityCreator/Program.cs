using EntityCreator;
using Microsoft.Extensions.Configuration;
using System;
using System.Linq;

// =====================
// MENÜLER
// =====================

static string AskTableNameFromDb(string connectionString)
{
    var tables = Helper.GetTableNames(connectionString);

    if (!tables.Any())
    {
        Console.WriteLine("Veritabanında tablo bulunamadı!");
        return string.Empty;
    }

    Console.WriteLine("Tablo Seçiniz:");
    Console.WriteLine(new string('-', 40));

    for (int i = 0; i < tables.Count; i++)
        Console.WriteLine($"{i + 1}) {tables[i]}");

    Console.WriteLine();
    Console.Write("Seçiminiz (numara) : ");

    if (!int.TryParse(Console.ReadLine(), out var choice))
        return string.Empty;

    if (choice < 1 || choice > tables.Count)
        return string.Empty;

    return tables[choice - 1];
}


static int AskMainMenu(int? lastChoice, string sonsecimTablo, string sonsecimLayers)
{
    Console.WriteLine("1) Tüm layer’ları üret");
    Console.WriteLine("2) Layer seçerek üret");
    Console.WriteLine($"3) Son Seçime göre tekrar üret.");
    Console.WriteLine($"   Son Seçilen Tablo: {sonsecimTablo}");
    Console.WriteLine($"   Son seçilen Katmanlar: {sonsecimLayers}");
    Console.WriteLine("4) Çıkış");
    Console.Write($"Seçiminiz:");


    var input = Console.ReadLine();
    if (string.IsNullOrWhiteSpace(input))
        return lastChoice ?? 0;

    return int.TryParse(input, out var x) ? x : 0;
}


static List<int> AskLayerSelection(List<int>? last, List<Target> targets)
{
    Console.WriteLine("Layer Seçimi:");

    foreach (var item in targets)
    {
        Console.WriteLine(item.OperationName);
    }

    var lastText = last != null && last.Any()
        ? string.Join(",", last)
        : "";

    Console.Write($"Seçimler (1,3,5):");
    var input = Console.ReadLine();

    if (string.IsNullOrWhiteSpace(input))
        return last ?? new();

    return input
        .Split(',', StringSplitOptions.RemoveEmptyEntries)
        .Select(x => int.TryParse(x.Trim(), out var i) ? i : -1)
        .Where(x => x > 0)
        .Distinct()
        .ToList();
}

static string AskYesNoExit(string message)
{
    Console.WriteLine(message);
    Console.Write("Seçiminiz (E/H/C): ");
    return Console.ReadLine()?.Trim().ToUpper() ?? "H";
}

static string AskTableSelection(string connectionStr, string lastTableName)
{
    Console.WriteLine(new string('-', 100));
    Console.WriteLine("Tablo nasıl seçilsin?");
    Console.WriteLine("1) Veritabanından seç");
    Console.WriteLine("2) Manuel tablo adı gir");
    Console.Write("Seçiminiz: ");

    var mode = Console.ReadLine();

    if (mode == "1")
        return AskTableNameFromDb(connectionStr);

    if (mode == "2")
    {
        Console.Write($"Tablo Adı: ");
        return Console.ReadLine()?.Trim() ?? string.Empty;
    }

    return string.Empty;
}

static string BuildLayerText(LastSelections last, List<Target> targets)
{
    if (last.Layers == null || !last.Layers.Any())
        return "-";

    return string.Join("; ",
        targets
            .Where(t => last.Layers.Contains(t.OrderNo))
            .Select(t => t.OperationName)
    );
}


// =====================
// CONFIG
// =====================
var configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.Development.local.json", optional: false)
    .Build();

string? connectionStr = configuration.GetConnectionString("DefaultConnection");
if (string.IsNullOrWhiteSpace(connectionStr))
{
    Console.WriteLine("Connection string bulunamadı!");
    return;
}

string solutionRoot =
    Directory.GetParent(AppContext.BaseDirectory)!
        .Parent!.Parent!.Parent!.Parent!.FullName;

// =====================
// TARGETS
// =====================
List<Target> targets = new()
{
    new Target(1, solutionRoot, @"EntityCreator\CRUDSP", false, ".generated.sql", new CrudSpAction(),"1 - CRUD SP"),
    new Target(2, solutionRoot, "SeramikStore.Entities", false, ".generated.cs", new EntityAction(),"2 - Entity"),
    new Target(3, solutionRoot, "SeramikStore.Contracts", true, "", new DtoAction(),"3 - DTO"),
    new Target(4, solutionRoot, "SeramikStore.Services", true, "", new ServiceAction(),"4 - Service"),
    new Target(5, solutionRoot, "SeramikStore.Web", true, "", new ViewModelAction(),"5 - ViewModel"),
    new Target(6, solutionRoot, @"SeramikStore.Web\Controllers", true, "Controller.generated.cs", new ControllerAction(),"6 - Controller"),
    new Target(7, solutionRoot, @"SeramikStore.Web\Views", true, "", new ViewAction(),"7 - View"),
    new Target(8, solutionRoot, @"SeramikStore.Web\Localization", true, "Resource.generated.cs", new  LocalizationMarkerAction(),"8 - LocalizationMaker"),

   
};

// =====================
// MAIN LOOP
// =====================
while (true)
{
    Console.Clear();
    Console.WriteLine("WELCOME TO ENTITY CREATOR");
    Console.WriteLine(new string('-', 100));

    var last = LastSelectionStore.Load();
    var lastLayersText = BuildLayerText(last, targets);

    var mainChoice = AskMainMenu(last.MainMenu, last.TableName, lastLayersText);

    if (mainChoice == 4)
        return;

    List<Target> selectedTargets;
    string tableName;
    string tableMode;

    switch (mainChoice)
    {
        case 1: // TÜM LAYERLAR
            selectedTargets = targets;
            tableName = AskTableSelection(connectionStr, last.TableName);
            tableMode = "ALL";
            break;

        case 2: // SEÇEREK
            var selections = AskLayerSelection(last.Layers, targets);
            selectedTargets = targets
                .Where(t => selections.Contains(t.OrderNo))
                .ToList();

            if (!selectedTargets.Any())
            {
                Console.WriteLine("Hiç layer seçilmedi!");
                Console.ReadKey();
                continue;
            }

            tableName = AskTableSelection(connectionStr, last.TableName);
            tableMode = "CUSTOM";
            break;

        case 3: // SON SEÇİM
            if (string.IsNullOrWhiteSpace(last.TableName) || !last.Layers.Any())
            {
                Console.WriteLine("Kayıtlı bir son seçim yok!");
                Console.ReadKey();
                continue;
            }

            RunCreator(
                connectionStr,
                last.TableName,
                targets.Where(t => last.Layers.Contains(t.OrderNo)).ToList(),
                last.MainMenu,
                last.TableMode
            );

            if (AskYesNoExit("Yeni bir tablo için devam etmek ister misiniz?") != "E")
                return;

            continue;

        default:
            Console.WriteLine("Geçersiz seçim!");
            Console.ReadKey();
            continue;
    }

    if (string.IsNullOrWhiteSpace(tableName))
    {
        Console.WriteLine("Geçerli bir tablo seçilmedi!");
        Console.ReadKey();
        continue;
    }

    RunCreator(connectionStr, tableName, selectedTargets, mainChoice, tableMode);
    if (AskYesNoExit("Yeni bir tablo için devam etmek ister misiniz?") != "E")
        return;
}


void RunCreator(
    string connectionStr,
    string tableName,
    List<Target> selectedTargets,
    int mainChoice,
    string tableMode)
{
    Console.WriteLine();
    Console.WriteLine($"Tablo: {tableName}");
    Console.WriteLine();

    foreach (var target in selectedTargets)
    {
        target.TableName = tableName;
        target.ConnectionString = connectionStr;
        Console.WriteLine(target.WelcomeText);
        Console.WriteLine(target.FileFullPath);
    }

    var ans = AskYesNoExit("CREATOR çalışacak. Emin misiniz?");

    if (ans != "E")
        return;

    foreach (var target in selectedTargets)
    {
        target.Execute();
        Console.WriteLine($"{target.ProjectName} başarıyla oluşturuldu.");
    }

    LastSelectionStore.Save(new LastSelections
    {
        MainMenu = mainChoice,
        Layers = selectedTargets.Select(t => t.OrderNo).ToList(),
        TableMode = tableMode,
        TableName = tableName
    });

    Console.WriteLine($"{tableName} için code generation tamamlandı.");
}
