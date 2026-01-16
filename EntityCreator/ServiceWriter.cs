using System.Text;

public static class ServiceWriter
{
    public static string GenerateService(
        string ns,
        string contractNs,
        string entity,
        List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine("using System;");
        sb.AppendLine("using System.Data;");
        sb.AppendLine("using Microsoft.Data.SqlClient;");
        sb.AppendLine("using System.Collections.Generic;");
        sb.AppendLine($"using {contractNs};");
        sb.AppendLine("using SeramikStore.Contracts.Common;");
        sb.AppendLine();
        sb.AppendLine($"namespace {ns}");
        sb.AppendLine("{");
        sb.AppendLine(GenerateInterface(entity));
        sb.AppendLine();
        sb.AppendLine(GenerateImplementation(entity, cols));
        sb.AppendLine("}");
        return sb.ToString();
    }

    // ---------------- INTERFACE ----------------
    static string GenerateInterface(string entity)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"    public interface I{entity}Service");
        sb.AppendLine("    {");
        sb.AppendLine($"        int Create({entity}CreateDto dto);");
        sb.AppendLine($"        void Update({entity}UpdateDto dto);");
        sb.AppendLine($"        void Delete(int id);");
        sb.AppendLine($"        void DeleteSoft(int id);");
        sb.AppendLine($"        {entity}Dto? GetById(int id);");
        sb.AppendLine($"        List<{entity}ListItemDto> List();");
        sb.AppendLine($"        PagedResult<{entity}ListItemDto> PagedList(int page, int pageSize);");
        sb.AppendLine("    }");
        return sb.ToString();
    }

    // ---------------- IMPLEMENTATION ----------------
    static string GenerateImplementation(string entity, List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"    public class {entity}Service : I{entity}Service");
        sb.AppendLine("    {");
        sb.AppendLine("        private readonly string _connectionString;");
        sb.AppendLine();
        sb.AppendLine($"        public {entity}Service(string connectionString)");
        sb.AppendLine("        {");
        sb.AppendLine("            _connectionString = connectionString;");
        sb.AppendLine("        }");
        sb.AppendLine();
        sb.AppendLine(GenerateCreate(entity, cols));
        sb.AppendLine();
        sb.AppendLine(GenerateUpdate(entity, cols));
        sb.AppendLine();
        sb.AppendLine(GenerateDelete(entity));
        sb.AppendLine();
        sb.AppendLine(GenerateDeleteSoft(entity));
        sb.AppendLine();
        sb.AppendLine(GenerateGetById(entity, cols));
        sb.AppendLine();
        sb.AppendLine(GenerateList(entity, cols));
        sb.AppendLine();
        sb.AppendLine(GeneratePagedList(entity, cols));
        sb.AppendLine("    }");
        return sb.ToString();
    }

    // ---------------- CREATE ----------------
    static string GenerateCreate(string entity, List<DbColumn> cols)
    {
        var insertCols = cols
            .Where(c => !c.IsIdentity && !c.IsInsertDate() && !c.IsUpdateDate() && !c.IsIsActive())
            .ToList();

        var sb = new StringBuilder();
        sb.AppendLine($"        public int Create({entity}CreateDto dto)");
        sb.AppendLine("        {");
        sb.AppendLine("            // BUSINESS RULES");
        sb.AppendLine();
        sb.AppendLine("            using var conn = new SqlConnection(_connectionString);");
        sb.AppendLine($"            using var cmd = new SqlCommand(\"sp_{entity}_Insert\", conn);");
        sb.AppendLine("            cmd.CommandType = CommandType.StoredProcedure;");
        foreach (var c in insertCols)
            sb.AppendLine($"            cmd.Parameters.AddWithValue(\"@{c.Name}\", dto.{c.Name});");
        sb.AppendLine("            conn.Open();");
        sb.AppendLine("            return Convert.ToInt32(cmd.ExecuteScalar());");
        sb.AppendLine("        }");
        return sb.ToString();
    }

    // ---------------- UPDATE ----------------
    static string GenerateUpdate(string entity, List<DbColumn> cols)
    {
        var id = cols.First(c => c.IsIdentity);
        var updateCols = cols.Where(c => !c.IsIdentity && !c.IsInsertDate()).ToList();

        var sb = new StringBuilder();
        sb.AppendLine($"        public void Update({entity}UpdateDto dto)");
        sb.AppendLine("        {");
        sb.AppendLine("            // BUSINESS RULES");
        sb.AppendLine();
        sb.AppendLine("            using var conn = new SqlConnection(_connectionString);");
        sb.AppendLine($"            using var cmd = new SqlCommand(\"sp_{entity}_Update\", conn);");
        sb.AppendLine("            cmd.CommandType = CommandType.StoredProcedure;");
        sb.AppendLine($"            cmd.Parameters.AddWithValue(\"@{id.Name}\", dto.{id.Name});");
        foreach (var c in updateCols)
            sb.AppendLine($"            cmd.Parameters.AddWithValue(\"@{c.Name}\", dto.{c.Name});");
        sb.AppendLine("            conn.Open();");
        sb.AppendLine("            cmd.ExecuteNonQuery();");
        sb.AppendLine("        }");
        return sb.ToString();
    }

    // ---------------- DELETE ----------------
    static string GenerateDelete(string entity) =>
$@"        public void Delete(int id)
        {{
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand(""sp_{entity}_Delete"", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue(""@Id"", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }}";

    static string GenerateDeleteSoft(string entity) =>
$@"        public void DeleteSoft(int id)
        {{
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand(""sp_{entity}_DeleteSoft"", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue(""@Id"", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }}";

    // ---------------- GET BY ID ----------------
    static string GenerateGetById(string entity, List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"        public {entity}Dto? GetById(int id)");
        sb.AppendLine("        {");
        sb.AppendLine("            using var conn = new SqlConnection(_connectionString);");
        sb.AppendLine($"            using var cmd = new SqlCommand(\"sp_{entity}_GetById\", conn);");
        sb.AppendLine("            cmd.CommandType = CommandType.StoredProcedure;");
        sb.AppendLine("            cmd.Parameters.AddWithValue(\"@Id\", id);");
        sb.AppendLine("            conn.Open();");
        sb.AppendLine("            using var rdr = cmd.ExecuteReader();");
        sb.AppendLine("            if (!rdr.Read()) return null;");
        sb.AppendLine();
        sb.AppendLine($"            return new {entity}Dto");
        sb.AppendLine("            {");
        foreach (var c in cols)
            sb.AppendLine($"                {c.Name} = ({MapClr(c)})rdr[\"{c.Name}\"],");
        sb.AppendLine("            };");
        sb.AppendLine("        }");
        return sb.ToString();
    }

    // ---------------- LIST ----------------
    static string GenerateList(string entity, List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"        public List<{entity}ListItemDto> List()");
        sb.AppendLine("        {");
        sb.AppendLine($"            var list = new List<{entity}ListItemDto>();");
        sb.AppendLine("            using var conn = new SqlConnection(_connectionString);");
        sb.AppendLine($"            using var cmd = new SqlCommand(\"sp_{entity}_List\", conn);");
        sb.AppendLine("            cmd.CommandType = CommandType.StoredProcedure;");
        sb.AppendLine("            conn.Open();");
        sb.AppendLine("            using var rdr = cmd.ExecuteReader();");
        sb.AppendLine("            while (rdr.Read())");
        sb.AppendLine("            {");
        sb.AppendLine($"                list.Add(new {entity}ListItemDto");
        sb.AppendLine("                {");
        foreach (var c in cols.Where(c => !c.IsUpdateDate()))
            sb.AppendLine($"                    {c.Name} = ({MapClr(c)})rdr[\"{c.Name}\"],");
        sb.AppendLine("                });");
        sb.AppendLine("            }");
        sb.AppendLine("            return list;");
        sb.AppendLine("        }");
        return sb.ToString();
    }

    // ---------------- PAGED LIST ----------------
    static string GeneratePagedList(string entity, List<DbColumn> cols)
    {
        var sb = new StringBuilder();
        sb.AppendLine($"        public PagedResult<{entity}ListItemDto> PagedList(int page, int pageSize)");
        sb.AppendLine("        {");
        sb.AppendLine($"            var result = new PagedResult<{entity}ListItemDto>();");
        sb.AppendLine("            using var conn = new SqlConnection(_connectionString);");
        sb.AppendLine($"            using var cmd = new SqlCommand(\"sp_{entity}_PagedList\", conn);");
        sb.AppendLine("            cmd.CommandType = CommandType.StoredProcedure;");
        sb.AppendLine("            cmd.Parameters.AddWithValue(\"@Page\", page);");
        sb.AppendLine("            cmd.Parameters.AddWithValue(\"@PageSize\", pageSize);");
        sb.AppendLine("            conn.Open();");
        sb.AppendLine("            using var rdr = cmd.ExecuteReader();");
        sb.AppendLine("            while (rdr.Read())");
        sb.AppendLine("            {");
        sb.AppendLine($"                result.Items.Add(new {entity}ListItemDto");
        sb.AppendLine("                {");
        foreach (var c in cols.Where(c => !c.IsUpdateDate()))
            sb.AppendLine($"                    {c.Name} = ({MapClr(c)})rdr[\"{c.Name}\"],");
        sb.AppendLine("                });");
        sb.AppendLine("            }");
        sb.AppendLine();
        sb.AppendLine("            if (rdr.NextResult() && rdr.Read())");
        sb.AppendLine("                result.TotalCount = (int)rdr[\"TotalCount\"];");
        sb.AppendLine();
        sb.AppendLine("            return result;");
        sb.AppendLine("        }");
        return sb.ToString();
    }

    static string MapClr(DbColumn c)
        => c.SqlType switch
        {
            "int" => "int",
            "bit" => "bool",
            "decimal" => "decimal",
            "datetime" => "DateTime",
            _ => "string"
        };
}
