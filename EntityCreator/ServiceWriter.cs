using System.Text;

public static class ServiceWriter
{
    public static string GenerateService(
        string ns,
        string table,
        List<DbColumn> cols)
    {
        var entity = table;
        var sb = new StringBuilder();

        sb.AppendLine("using Dapper;");
        sb.AppendLine("using System.Data;");
        sb.AppendLine();
        sb.AppendLine($"namespace {ns}");
        sb.AppendLine("{");

        sb.AppendLine($"    public interface I{entity}Service");
        sb.AppendLine("    {");
        sb.AppendLine($"        Task<int> CreateAsync({entity}CreateDto dto);");
        sb.AppendLine($"        Task UpdateAsync({entity}UpdateDto dto);");
        sb.AppendLine("        Task DeleteAsync(int id);");
        sb.AppendLine("        Task DeleteSoftAsync(int id);");
        sb.AppendLine($"        Task<{entity}Dto?> GetByIdAsync(int id);");
        sb.AppendLine($"        Task<List<{entity}ListItemDto>> ListAsync();");
        sb.AppendLine($"        Task<PagedResult<{entity}ListItemDto>> PagedListAsync(int page, int pageSize);");
        sb.AppendLine("    }");
        sb.AppendLine();

        sb.AppendLine($"    public class {entity}Service : I{entity}Service");
        sb.AppendLine("    {");
        sb.AppendLine("        private readonly IDbConnection _connection;");
        sb.AppendLine();
        sb.AppendLine($"        public {entity}Service(IDbConnection connection)");
        sb.AppendLine("        {");
        sb.AppendLine("            _connection = connection;");
        sb.AppendLine("        }");
        sb.AppendLine();

        sb.AppendLine($"        public Task<int> CreateAsync({entity}CreateDto dto)");
        sb.AppendLine("            => _connection.ExecuteScalarAsync<int>(");
        sb.AppendLine($"                \"sp_{entity}_Insert\", dto, commandType: CommandType.StoredProcedure);");

        // (Diğer metotları da aynı pattern ile eklersin)

        sb.AppendLine("    }");
        sb.AppendLine("}");

        return sb.ToString();
    }
}
