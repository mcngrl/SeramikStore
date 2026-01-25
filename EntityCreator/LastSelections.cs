public sealed class LastSelections
{
    public int MainMenu { get; set; }               // 1 veya 2
    public List<int> Layers { get; set; } = new();  // 1,3,5
    public string TableMode { get; set; } = "1";    // "1" / "2"
    public string TableName { get; set; } = "";
}