using System.Text;

public static class DtoWriter
{
    public static string GenerateDtos(
        string ns,
        string entityName,
        List<DbColumn> columns)
    {
        var sb = new StringBuilder();

        sb.AppendLine("using System;");
        sb.AppendLine();
        sb.AppendLine($"namespace {ns}");
        sb.AppendLine("{");

        sb.AppendLine(GenerateDto(entityName, columns));
        sb.AppendLine();
        sb.AppendLine(GenerateCreateDto(entityName, columns));
        sb.AppendLine();
        sb.AppendLine(GenerateUpdateDto(entityName, columns));
        sb.AppendLine();
        sb.AppendLine(GenerateListItemDto(entityName, columns));

        sb.AppendLine("}");
        return sb.ToString();
    }

    // -------------------------
    // Base DTO (Get / Detail)
    // -------------------------
    static string GenerateDto(string name, List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"    public class {name}Dto");
        sb.AppendLine("    {");

        //foreach (var c in cols.Where(IncludeInRead))
        foreach (var c in cols)
            sb.AppendLine($"        public {ToCSharp(c)} {c.Name} {{ get; set; }}");

        sb.AppendLine("    }");
        return sb.ToString();
    }

    // -------------------------
    // CREATE DTO
    // -------------------------
    static string GenerateCreateDto(string name, List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"    public class {name}CreateDto");
        sb.AppendLine("    {");

        foreach (var c in cols.Where(IncludeInCreate))
            sb.AppendLine($"        public {ToCSharp(c)} {c.Name} {{ get; set; }}");

        sb.AppendLine("    }");
        return sb.ToString();
    }

    // -------------------------
    // UPDATE DTO
    // -------------------------
    static string GenerateUpdateDto(string name, List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"    public class {name}UpdateDto");
        sb.AppendLine("    {");

        foreach (var c in cols.Where(IncludeInUpdate))
            sb.AppendLine($"        public {ToCSharp(c)} {c.Name} {{ get; set; }}");

        sb.AppendLine("    }");
        return sb.ToString();
    }

    // -------------------------
    // LIST ITEM DTO
    // -------------------------
    static string GenerateListItemDto(string name, List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"    public class {name}ListItemDto");
        sb.AppendLine("    {");

        foreach (var c in cols.Where(IncludeInList))
            sb.AppendLine($"        public {ToCSharp(c)} {c.Name} {{ get; set; }}");

        sb.AppendLine("    }");
        return sb.ToString();
    }

    // -------------------------
    // Filters
    // -------------------------
    static bool IncludeInRead(DbColumn c)
        => !c.IsUpdateDate();

    static bool IncludeInCreate(DbColumn c)
        => !c.IsIdentity &&
           !c.IsInsertDate() &&
           !c.IsUpdateDate() &&
           !c.IsIsActive();

    static bool IncludeInUpdate(DbColumn c)
        => !c.IsInsertDate();

    static bool IncludeInList(DbColumn c)
        => !c.IsUpdateDate();

    // -------------------------
    // Type Mapper
    // -------------------------
    static string ToCSharp(DbColumn c)
    {
        var type = c.SqlType switch
        {
            "int" => "int",
            "bit" => "bool",
            "decimal" => "decimal",
            "datetime" => "DateTime",
            "nvarchar" or "varchar" => "string",
            _ => "string"
        };

        if (type != "string" && c.IsNullable)
            return type + "?";

        return type;
    }
}
