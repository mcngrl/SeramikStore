public sealed class SqlClrTypeInfo
{
    public string ClrType { get; init; } = default!;
    public bool IsReferenceType { get; init; }
    public bool IsNeverNullable { get; init; } // timestamp / rowversion
}
