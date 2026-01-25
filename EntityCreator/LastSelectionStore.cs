using System.Text.Json;

static class LastSelectionStore
{
    private const string FileName = "lastSelections.json";

    public static LastSelections Load()
    {
        if (!File.Exists(FileName))
            return new LastSelections();

        var json = File.ReadAllText(FileName);
        return JsonSerializer.Deserialize<LastSelections>(json)
               ?? new LastSelections();
    }

    public static void Save(LastSelections data)
    {
        var json = JsonSerializer.Serialize(data, new JsonSerializerOptions
        {
            WriteIndented = true
        });
        File.WriteAllText(FileName, json);
    }
}
