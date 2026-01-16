using System.Text;

public static class RepositoryWriter
{
    public static string GenerateRepository(
        string ns,
        string table,
        List<DbColumn> cols)
    {
        var entity = table;
        var sb = new StringBuilder();

        sb.AppendLine("using System;");
        sb.AppendLine("using System.Data;");
        sb.AppendLine("using Microsoft.Data.SqlClient;");
        sb.AppendLine("using System.Collections.Generic;");
        sb.AppendLine();
        sb.AppendLine($"namespace {ns}");
        sb.AppendLine("{");

        sb.AppendLine(GenerateInterface(entity));
        sb.AppendLine();
        sb.AppendLine(GenerateImplementation(entity, cols));

        sb.AppendLine("}");
        return sb.ToString();
    }
    static string GenerateInterface(string entity)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"    public interface I{entity}Repository");
        sb.AppendLine("    {");
        sb.AppendLine($"        int Insert({entity}CreateDto dto);");
        sb.AppendLine($"        void Update({entity}UpdateDto dto);");
        sb.AppendLine($"        void Delete(int id);");
        sb.AppendLine($"        void DeleteSoft(int id);");
        sb.AppendLine($"        {entity}Dto? GetById(int id);");
        sb.AppendLine($"        List<{entity}ListItemDto> List();");
        sb.AppendLine($"        PagedResult<{entity}ListItemDto> PagedList(int page, int pageSize);");
        sb.AppendLine("    }");
        return sb.ToString();
    }
    static string GenerateImplementation(string entity, List<DbColumn> cols)
    {
        var sb = new StringBuilder();

        sb.AppendLine($"    public class {entity}Repository : I{entity}Repository");
        sb.AppendLine("    {");
        sb.AppendLine("        private readonly string _connectionString;");
        sb.AppendLine();
        sb.AppendLine($"        public {entity}Repository(string connectionString)");
        sb.AppendLine("        {");
        sb.AppendLine("            _connectionString = connectionString;");
        sb.AppendLine("        }");
        sb.AppendLine();

        sb.AppendLine(GenerateInsert(entity, cols));
        sb.AppendLine(GenerateUpdate(entity, cols));

        sb.AppendLine("    }");
        return sb.ToString();
    }

    static string GenerateInsert(string entity, List<DbColumn> cols)
    {
        var sb = new StringBuilder();

        var insertCols = cols
            .Where(c => !c.IsIdentity && !c.IsInsertDate() && !c.IsUpdateDate())
            .ToList();

        sb.AppendLine($"        public int Insert({entity}CreateDto dto)");
        sb.AppendLine("        {");
        sb.AppendLine("            using var conn = new SqlConnection(_connectionString);");
        sb.AppendLine($"            using var cmd = new SqlCommand(\"sp_{entity}_Insert\", conn);");
        sb.AppendLine("            cmd.CommandType = CommandType.StoredProcedure;");
        sb.AppendLine();

        foreach (var c in insertCols.Where(c => !c.IsIsActive()))
            sb.AppendLine($"            cmd.Parameters.AddWithValue(\"@{c.Name}\", dto.{c.Name});");

        sb.AppendLine();
        sb.AppendLine("            conn.Open();");
        sb.AppendLine("            return Convert.ToInt32(cmd.ExecuteScalar());");
        sb.AppendLine("        }");

        return sb.ToString();
    }

    static string GenerateUpdate(string entity, List<DbColumn> cols)
    {
        var sb = new StringBuilder();

        var id = cols.First(c => c.IsIdentity);

        var updateCols = cols
            .Where(c => !c.IsIdentity && !c.IsInsertDate())
            .ToList();

        sb.AppendLine($"        public void Update({entity}UpdateDto dto)");
        sb.AppendLine("        {");
        sb.AppendLine("            using var conn = new SqlConnection(_connectionString);");
        sb.AppendLine($"            using var cmd = new SqlCommand(\"sp_{entity}_Update\", conn);");
        sb.AppendLine("            cmd.CommandType = CommandType.StoredProcedure;");
        sb.AppendLine();

        // Id param
        sb.AppendLine($"            cmd.Parameters.AddWithValue(\"@{id.Name}\", dto.{id.Name});");

        // Diğer kolonlar
        foreach (var c in updateCols)
        {
            sb.AppendLine(
                $"            cmd.Parameters.AddWithValue(\"@{c.Name}\", " +
                $"dto.{c.Name} ?? (object)DBNull.Value);"
            );
        }

        sb.AppendLine();
        sb.AppendLine("            conn.Open();");
        sb.AppendLine("            cmd.ExecuteNonQuery();");
        sb.AppendLine("        }");

        return sb.ToString();
    }
}

