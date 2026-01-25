using EntityCreator;
using Microsoft.Extensions.Configuration;
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

//static int AskMainMenu()
//{
//    Console.WriteLine("1) Tüm layer’ları üret");
//    Console.WriteLine("2) Layer seçerek üret");
//    Console.WriteLine("3) Çıkış");
//    Console.Write("Seçiminiz: ");
//    return int.TryParse(Console.ReadLine(), out var x) ? x : 0;
//}

static int AskMainMenu(int? lastChoice)
{
    Console.WriteLine("1) Tüm layer’ları üret");
    Console.WriteLine("2) Layer seçerek üret");
    Console.WriteLine("3) Son Seçime göre tekrar üret");
    Console.WriteLine("4) Çıkış");
    Console.Write($"Seçiminiz:[{lastChoice}]");


    var input = Console.ReadLine();
    if (string.IsNullOrWhiteSpace(input))
        return lastChoice ?? 0;

    return int.TryParse(input, out var x) ? x : 0;
}


static List<int> AskLayerSelection(List<int>? last)
{
    Console.WriteLine("Layer Seçimi:");
    Console.WriteLine("1 - CRUD SP");
    Console.WriteLine("2 - Entity");
    Console.WriteLine("3 - DTO");
    Console.WriteLine("4 - Service");
    Console.WriteLine("5 - ViewModel");
    Console.WriteLine("6 - Controller");
    Console.WriteLine("7 - View");
    Console.WriteLine("8 - LocalizationMaker");

    var lastText = last != null && last.Any()
        ? string.Join(",", last)
        : "";

    Console.Write($"Seçimler (1,3,5) [{lastText}]:");
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
    new Target(1, solutionRoot, @"EntityCreator\CRUDSP", false, ".generated.sql", new CrudSpAction()),
    new Target(2, solutionRoot, "SeramikStore.Entities", false, ".generated.cs", new EntityAction()),
    new Target(3, solutionRoot, "SeramikStore.Contracts", true, "", new DtoAction()),
    new Target(4, solutionRoot, "SeramikStore.Services", true, "", new ServiceAction()),
    new Target(5, solutionRoot, "SeramikStore.Web", true, "", new ViewModelAction()),
    new Target(6, solutionRoot, @"SeramikStore.Web\Controllers", true, "Controller.generated.cs", new ControllerAction()),
    new Target(7, solutionRoot, @"SeramikStore.Web\Views", true, "", new ViewAction()),
    new Target(8, solutionRoot, @"SeramikStore.Web\Localization", true, "Resource.generated.cs", new  LocalizationMarkerAction()),

   
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

    var mainChoice = AskMainMenu(last.MainMenu);
    if (mainChoice == 4)
        return;

    string tableName = string.Empty;

    List<Target> selectedTargets;

    if (mainChoice == 1)
    {
        // TÜM LAYER’LAR
        selectedTargets = targets;
    }
    else if (mainChoice == 2)
    {
        // SEÇEREK
        var selections = AskLayerSelection(last.Layers);
        selectedTargets = targets
            .Where(t => selections.Contains(t.OrderNo))
            .ToList();

        if (!selectedTargets.Any())
        {
            Console.WriteLine("Hiç layer seçilmedi!");
            Console.ReadKey();
            continue;
        }
    }
    else if (mainChoice == 3)
    {
        mainChoice = last.MainMenu;
        selectedTargets = targets
            .Where(t => last.Layers.Contains(t.OrderNo))
            .ToList();
        tableName = last.TableName;
        RunCreator(connectionStr, tableName, selectedTargets, last.MainMenu, last.TableMode);
        continue;

    }

    else
    {
        Console.WriteLine("Geçersiz seçim!");
        Console.ReadKey();
        continue;
    }

    Console.WriteLine(new string('-', 100));
    Console.WriteLine("Tablo nasıl seçilsin?");
    Console.WriteLine("1) Veritabanından seç");
    Console.WriteLine("2) Manuel tablo adı gir");
    Console.Write($"Seçiminiz: [{last.TableMode}]:");

    var tableMode = Console.ReadLine();
  


    if (tableMode == "1")
    {
        tableName = AskTableNameFromDb(connectionStr);
    }
    else if (tableMode == "2")
    {
        Console.Write($"Tablo Adı [{last.TableName}]: ");
        tableName = Console.ReadLine()?.Trim() ?? "";
    }

    if (string.IsNullOrWhiteSpace(tableName))
    {
        Console.WriteLine("Geçerli bir tablo seçilmedi!");
        Console.ReadKey();
        continue;
    }
    
    RunCreator(connectionStr, tableName, selectedTargets,mainChoice,tableMode);

    Console.WriteLine();
    var again = AskYesNoExit("Yeni bir tablo için devam etmek ister misiniz?");
    if (again != "E")
        return;
}

void RunCreator(string connectionStr, string tableName, List<Target> selectedTargets, int mainChoice, string tableMode)
{
    Console.WriteLine();
    Console.Write("Tablo: " + tableName);
    Console.WriteLine();
    // =======================
    // GENERATION FINAL ONAY
    // =======================
    foreach (var targetItem in selectedTargets)
    {
        targetItem.TableName = tableName;
        targetItem.ConnectionString = connectionStr;


        Console.WriteLine(targetItem.WelcomeText);
        Console.WriteLine(targetItem.FileFullPath);
    }




    Console.WriteLine();
    var ans = AskYesNoExit(" CREATOR Çalışacak Emin misiniz?");

    if (ans == "H")
    {
        Console.WriteLine();
        Console.WriteLine($"{tableName} için code generation iptal Edildi.");
    }

    if (ans == "C")
    {
        return;
    }


    if (ans == "E")
    {
        foreach (var targetItem in selectedTargets)
        {
            targetItem.TableName = tableName;
            targetItem.ConnectionString = connectionStr;

            Console.WriteLine();
            Console.WriteLine(targetItem.WelcomeText);
            Console.WriteLine(targetItem.FileFullPath);
            targetItem.Execute();
            Console.WriteLine($"{targetItem.ProjectName} başarıyla oluşturuldu.");
        }
        Console.WriteLine();
        Console.WriteLine($"{tableName} için code generation tamamlandı.");

        LastSelectionStore.Save(new LastSelections
        {
            MainMenu = mainChoice,
            Layers = selectedTargets.Select(t => t.OrderNo).ToList(),
            TableMode = tableMode,
            TableName = tableName
        });
    }
}