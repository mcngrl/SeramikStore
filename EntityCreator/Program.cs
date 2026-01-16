using Microsoft.Extensions.Configuration;

static string AskYesNoExit(string message)
{
    Console.WriteLine();
    Console.WriteLine(message);
    Console.Write("Seçiminiz (E/H/C): ");
    return Console.ReadLine()?.Trim().ToUpper() ?? "H";
}

var configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.Development.local.json", optional: false)
    .Build();

string? connectionString = configuration.GetConnectionString("DefaultConnection");
if (string.IsNullOrWhiteSpace(connectionString))
{
    Console.WriteLine("Connection string bulunamadı!");
    return;
}

string solutionRoot = Directory.GetParent(AppContext.BaseDirectory)!.Parent!.Parent!.Parent!.Parent!.FullName;
string projectRoot = Directory.GetParent(AppContext.BaseDirectory)!.Parent!.Parent!.Parent!.FullName;

string folderForEntity = Path.Combine(solutionRoot, "SeramikStore.Entities");
string folderForDTO = Path.Combine(Path.Combine(solutionRoot, "SeramikStore.Services"), "DTOs");
string folderForSP = Path.Combine(projectRoot, "CRUDSP");

while (true)
{
    Console.Clear();
    Console.WriteLine("WELCOME TO ENTITY CREATOR");
    Console.WriteLine(new string('-', 100));
    Console.WriteLine("CONNECTION STRING:");
    Console.WriteLine(connectionString);
    Console.WriteLine(new string('-', 100));

    Console.Write("Tablo Adı ? : ");
    string? tableName = Console.ReadLine()?.Trim();

    if (string.IsNullOrWhiteSpace(tableName))
    {
        Console.WriteLine("Tablo adı boş olamaz!");
        continue;
    }

    string className = tableName;
    string entityFile = Path.Combine(folderForEntity, $"{tableName}.cs");
    string DTOFile = Path.Combine(folderForDTO, $"{tableName}Dto.cs");
    string spFile = Path.Combine(
        folderForSP,
        $"SP_CRUD_{tableName}_{DateTime.Now:yyyyMMddHHmmss}.sql"
    );

    // =======================
    // ADIM 1 - ENTITY
    // =======================
    Console.WriteLine();
    Console.WriteLine("ADIM 1) Entity Oluşturma");
    Console.WriteLine(entityFile);

    var step1 = AskYesNoExit("Devam edilsin mi?");
    if (step1 == "C") return;

    if (step1 == "E")
    {
        try
        {
            EntityCreator.FileCreator.RunForEntityClass(
                connectionString, "dbo", tableName, className,
                "SeramikStore.Entities", entityFile);

            Console.WriteLine($"{tableName}.cs başarıyla oluşturuldu.");
        }
        catch (Exception ex)
        {
            Console.WriteLine("Entity oluşturulurken hata oluştu:");
            Console.WriteLine(ex);
        }
    }
    else
    {
        Console.WriteLine("ADIM 1 atlandı.");
    }

    // =======================
    // ADIM 2 - CRUD SP
    // =======================
    Console.WriteLine();
    Console.WriteLine("ADIM 2) CRUD Stored Procedure");
    Console.WriteLine(spFile);

    var step2 = AskYesNoExit("Devam edilsin mi?");
    if (step2 == "C") return;

    if (step2 == "E")
    {
        try
        {
            EntityCreator.FileCreator.RunCRUDSPSql(
                connectionString, "dbo", tableName, className,
                "SeramikStore.Entities", spFile);

            Console.WriteLine("CRUD SP scripti başarıyla oluşturuldu.");
        }
        catch (Exception ex)
        {
            Console.WriteLine("CRUD SP oluşturulurken hata oluştu:");
            Console.WriteLine(ex);
        }
    }
    else
    {
        Console.WriteLine("ADIM 2 atlandı.");
    }


    // =======================
    // ADIM 3 - DTO
    // =======================
    Console.WriteLine();
    Console.WriteLine("ADIM 3) DTO Oluşturma");
    Console.WriteLine(DTOFile);

    var step3 = AskYesNoExit("Devam edilsin mi?");
    if (step3 == "C") return;

    if (step3 == "E")
    {
        try
        {
            EntityCreator.FileCreator.RunDTO(
                connectionString, "dbo", tableName, className,
                "SeramikStore.Services.DTOs." + className, DTOFile);

            Console.WriteLine($"{tableName}Dto.cs başarıyla oluşturuldu.");
        }
        catch (Exception ex)
        {
            Console.WriteLine("DTO oluşturulurken hata oluştu:");
            Console.WriteLine(ex);
        }
    }
    else
    {
        Console.WriteLine("ADIM 3 atlandı.");
    }

    // =======================
    // BAŞA DÖN?
    // =======================
    var again = AskYesNoExit("Yeni bir tablo için devam etmek ister misiniz?");
    if (again != "E")
        return;
}
