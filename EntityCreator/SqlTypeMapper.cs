public static class SqlTypeMapper
{
    public static string ToCSharp(string sqlType, bool isNullable)
    {
        sqlType = sqlType.ToLowerInvariant();

        string type = sqlType switch
        {
            // ================= NUMERIC =================
            "tinyint" => "byte",
            "smallint" => "short",
            "int" => "int",
            "bigint" => "long",

            "decimal" => "decimal",
            "numeric" => "decimal",
            "money" => "decimal",
            "smallmoney" => "decimal",

            "float" => "double",
            "real" => "float",

            // ================= BOOLEAN =================
            "bit" => "bool",

            // ================= DATE / TIME =================
            "date" => "DateOnly",
            "datetime" => "DateTime",
            "datetime2" => "DateTime",
            "smalldatetime" => "DateTime",
            "datetimeoffset" => "DateTimeOffset",
            "time" => "TimeOnly",

            // ================= STRING =================
            "char" => "string",
            "varchar" => "string",
            "text" => "string",

            "nchar" => "string",
            "nvarchar" => "string",
            "ntext" => "string",

            // ================= BINARY =================
            "binary" => "byte[]",
            "varbinary" => "byte[]",
            "image" => "byte[]",

            // ================= UNIQUE =================
            "uniqueidentifier" => "Guid",

            // ================= XML / JSON =================
            "xml" => "string",

            // ================= SQL SERVER SPECIAL =================
            "rowversion" => "byte[]",
            "timestamp" => "byte[]",
            "sql_variant" => "object",

            // ================= SPATIAL =================
            "geometry" => "object",
            "geography" => "object",

            // ================= HIERARCHY =================
            "hierarchyid" => "object",

            // ================= FALLBACK =================
            _ => "object"
        };

        // ---------- NULLABILITY ----------
        // reference types
        if (type is "string" or "byte[]" or "object")
            return isNullable ? $"{type}?" : type;

        // value types
        return isNullable ? $"{type}?" : type;
    }
}
