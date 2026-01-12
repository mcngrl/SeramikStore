public static class SqlTypeMapper
{
    public static string ToCSharp(string sqlType, bool isNullable)
    {
        string type = sqlType switch
        {
            "int" => "int",
            "bigint" => "long",
            "bit" => "bool",
            "decimal" or "numeric" => "decimal",
            "float" => "double",
            "datetime" or "smalldatetime" => "DateTime",
            "nvarchar" or "varchar" or "nchar" or "char" => "string",
            _ => "string"
        };

        // reference type
        if (type == "string")
            return isNullable ? "string?" : "required string";

        // value type
        return isNullable ? $"{type}?" : type;
    }
}
