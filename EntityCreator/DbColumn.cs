public class DbColumn
{
    public string Name { get; set; }
    public string SqlType { get; set; }
    public int MaxLength { get; set; }
    public byte Precision { get; set; }
    public byte Scale { get; set; }
    public bool IsNullable { get; set; }
    public bool IsIdentity { get; set; }

}

