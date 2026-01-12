using EntityCreator;
using System.Text;
using static System.Runtime.InteropServices.JavaScript.JSType;

public static class SpWriter
{
    public static string GenerateCrudSp(
        string schema,
        string tableName,
        List<DbColumn> columns)
    {
        var sb = new StringBuilder();

        sb.AppendLine(GenerateInsert(schema, tableName, columns));
        sb.AppendLine("GO\n");
        sb.AppendLine(GenerateUpdate(schema, tableName, columns));
        sb.AppendLine("GO\n");
        //sb.AppendLine(GenerateDelete(schema, tableName));
        //sb.AppendLine("GO\n");
        //sb.AppendLine(GenerateGetById(schema, tableName, columns));
        //sb.AppendLine("GO\n");
        //sb.AppendLine(GenerateList(schema, tableName));

        return sb.ToString();
    }

    static string GenerateInsert(
    string schema,
    string table,
    List<DbColumn> cols)
    {
        var nonIdentity = cols.Where(c => !c.IsIdentity).ToList();

        var sb = new StringBuilder();
        sb.AppendLine($"CREATE PROCEDURE [{schema}].[sp_{table}_Insert]");

        sb.AppendLine(string.Join(",\n",
            nonIdentity.Select(c =>
                $"    @{c.Name} {c.SqlType}" +
                (c.IsNullable ? " = NULL" : "")
            )));

        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine("    INSERT INTO [" + schema + "].[" + table + "]");
        sb.AppendLine("    (" +
            string.Join(", ", nonIdentity.Select(c => $"[{c.Name}]")) + ")");
        sb.AppendLine("    VALUES");
        sb.AppendLine("    (" +
            string.Join(", ", nonIdentity.Select(c => $"@{c.Name}")) + ")");
        sb.AppendLine("    SELECT SCOPE_IDENTITY() AS NewId;");
        sb.AppendLine("END");

        return sb.ToString();
    }


    static string GenerateUpdate(
    string schema,
    string table,
    List<DbColumn> cols)
    {
        var id = cols.First(c => c.IsIdentity);
        var others = cols.Where(c => !c.IsIdentity).ToList();

        var sb = new StringBuilder();
        sb.AppendLine($"CREATE PROCEDURE [{schema}].[sp_{table}_Update]");
        sb.AppendLine($"    @{id.Name} {id.SqlType},");
        sb.AppendLine(string.Join(",\n",
            others.Select(c =>
                $"    @{c.Name} {c.SqlType}" +
                (c.IsNullable ? " = NULL" : "")
            )));

        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine($"    UPDATE [{schema}].[{table}]");
        sb.AppendLine("    SET");
        sb.AppendLine(string.Join(",\n",
            others.Select(c => $"        [{c.Name}] = @{c.Name}")));
        sb.AppendLine($"    WHERE [{id.Name}] = @{id.Name};");
        sb.AppendLine("END");

        return sb.ToString();
    }



}