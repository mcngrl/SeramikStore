    public static class SqlTypeMapper_old
    {
        public static string ToCSharp(string sqlType, bool isNullable)
        {
            sqlType = sqlType.ToLowerInvariant();

            // timestamp / rowversion
            if (sqlType is "timestamp" or "rowversion")
                return "required byte[]"; // SQL Server kuralı: ASLA nullable değil

            string type = sqlType switch
            {
                // ========= NUMERIC =========
                "tinyint" => "byte",
                "smallint" => "short",
                "int" => "int",
                "bigint" => "long",
                "decimal" or "numeric" => "decimal",
                "money" => "decimal",
                "smallmoney" => "decimal",
                "float" => "double",
                "real" => "float",

                // ========= BOOLEAN =========
                "bit" => "bool",

                // ========= DATE / TIME =========
                "date" => "DateOnly",
                "datetime" => "DateTime",
                "datetime2" => "DateTime",
                "smalldatetime" => "DateTime",
                "datetimeoffset" => "DateTimeOffset",
                "time" => "TimeOnly",

                // ========= STRING =========
                "char" or "varchar" or "text"
                    or "nchar" or "nvarchar" or "ntext"
                    => "string",

                // ========= BINARY =========
                "binary" or "varbinary" or "image"
                    => "byte[]",

                // ========= UNIQUE =========
                "uniqueidentifier" => "Guid",

                // ========= XML =========
                "xml" => "string",

                // ========= SQL SPECIAL =========
                "sql_variant" => "object",

                // ========= SPATIAL / OTHER =========
                "geometry" or "geography" or "hierarchyid"
                    => "object",

                _ => "object"
            };

            // ========= NULLABILITY =========

            // reference types
            if (type is "string" or "byte[]" or "object")
            {
                return isNullable
                    ? $"{type}?"
                    : $"required {type}";
            }

            // value types
            return isNullable
                ? $"{type}?"
                : type;
        }
    }

public static class SqlTypeMapper
{
    public static SqlClrTypeInfo Map(string sqlType)
    {
        sqlType = sqlType.ToLowerInvariant();

        // timestamp / rowversion → özel
        if (sqlType is "timestamp" or "rowversion")
        {
            return new SqlClrTypeInfo
            {
                ClrType = "byte[]",
                IsReferenceType = true,
                IsNeverNullable = true
            };
        }

        return sqlType switch
        {
            // ===== NUMERIC =====
            "tinyint" => Value("byte"),
            "smallint" => Value("short"),
            "int" => Value("int"),
            "bigint" => Value("long"),
            "decimal" or
            "numeric" or
            "money" or
            "smallmoney" => Value("decimal"),
            "float" => Value("double"),
            "real" => Value("float"),

            // ===== BOOLEAN =====
            "bit" => Value("bool"),

            // ===== DATE / TIME =====
            "date" => Value("DateOnly"),
            "datetime" or
            "datetime2" or
            "smalldatetime" => Value("DateTime"),
            "datetimeoffset" => Value("DateTimeOffset"),
            "time" => Value("TimeOnly"),

            // ===== STRING =====
            "char" or
            "varchar" or
            "text" or
            "nchar" or
            "nvarchar" or
            "ntext" or
            "xml" => Ref("string"),

            // ===== BINARY =====
            "binary" or
            "varbinary" or
            "image" => Ref("byte[]"),

            // ===== UNIQUE =====
            "uniqueidentifier" => Value("Guid"),

            // ===== OTHER =====
            "sql_variant" or
            "geometry" or
            "geography" or
            "hierarchyid" => Ref("object"),

            _ => Ref("object")
        };
    }

    private static SqlClrTypeInfo Value(string clr) =>
        new() { ClrType = clr, IsReferenceType = false };

    private static SqlClrTypeInfo Ref(string clr) =>
        new() { ClrType = clr, IsReferenceType = true };
}
