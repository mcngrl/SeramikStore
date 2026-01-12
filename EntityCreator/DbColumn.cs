public class DbColumn
{
    public string Name { get; set; }
    public string SqlType { get; set; }
    public bool IsNullable { get; set; }
    public bool IsIdentity { get; set; }
}