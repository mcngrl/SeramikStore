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

        if (columns.Count == 0)
        {
            return "";
        }

        var sb = new StringBuilder();

        sb.AppendLine(GenerateInsert(schema, tableName, columns));
        sb.AppendLine("GO\n");
        sb.AppendLine(GenerateUpdate(schema, tableName, columns));
        sb.AppendLine("GO\n");
        sb.AppendLine(GenerateDeleteHard(schema, tableName, columns));
        sb.AppendLine("GO\n");
        sb.AppendLine(GenerateDeleteSoft(schema, tableName, columns));
        sb.AppendLine("GO\n");
        sb.AppendLine(GenerateGetById(schema, tableName, columns));
        sb.AppendLine("GO\n");
        sb.AppendLine(GenerateList(schema, tableName, columns));
        sb.AppendLine("GO\n");
        sb.AppendLine(GeneratePagedList(schema, tableName, columns));

        return sb.ToString();
    }

    static string GenerateInsert(string schema, string table, List<DbColumn> cols)
    {
        var sb = new StringBuilder();

        // Identity hariç tüm kolonlar
        var insertCols = cols
            .Where(c => !c.IsIdentity && !c.IsUpdateDate())
            .ToList();

        sb.AppendLine($"CREATE OR ALTER PROCEDURE [{schema}].[sp_{table}_Insert]");

        // PARAMETRELER
        sb.AppendLine(string.Join(",\n",
            insertCols
                .Where(c => !c.IsInsertDate() && !c.IsIsActive())
                .Select(c =>
                    $"    @{c.Name} {DbSchemaReader.GetSqlType(c)}" +
                    (c.IsNullable ? " = NULL" : "")
                )));

        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine("    SET NOCOUNT ON;");
        sb.AppendLine();

        // INSERT COLUMNS
        sb.AppendLine($"    INSERT INTO [{schema}].[{table}]");
        sb.AppendLine("    (" + string.Join(", ",
            insertCols.Select(c => $"[{c.Name}]")
        ) + ")");

        // INSERT VALUES
        sb.AppendLine("    VALUES");
        sb.AppendLine("    (" + string.Join(", ",
            insertCols.Select(c =>
                c.IsInsertDate() ? "GETDATE()" :
                c.IsIsActive() ? "1" :
                $"@{c.Name}"
            )
        ) + ");");

        sb.AppendLine();
        sb.AppendLine("    SELECT SCOPE_IDENTITY() AS NewId;");
        sb.AppendLine("END");

        return sb.ToString();
    }
    static string GenerateUpdate(string schema, string table, List<DbColumn> cols)
    {
        var id = cols.First(c => c.IsIdentity);

        var updatable = cols
            .Where(c => !c.IsIdentity && !c.IsInsertDate())
            .ToList();

        var sb = new StringBuilder();

        sb.AppendLine($"CREATE OR ALTER PROCEDURE [{schema}].[sp_{table}_Update]");
        sb.AppendLine($"    @{id.Name} {DbSchemaReader.GetSqlType(id)},");
        sb.AppendLine(string.Join(",\n",
            updatable.Select(c =>
                $"    @{c.Name} {DbSchemaReader.GetSqlType(c)}" +
                (c.IsNullable ? " = NULL" : "")
            )));

        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine("    SET NOCOUNT ON;");
        sb.AppendLine();
        sb.AppendLine($"    UPDATE [{schema}].[{table}]");
        sb.AppendLine("    SET");

        sb.AppendLine(string.Join(",\n",
            updatable.Select(c =>
                c.IsUpdateDate()
                    ? "        [UpdateDate] = GETDATE()"
                    : $"        [{c.Name}] = @{c.Name}"
            )));

        sb.AppendLine($"    WHERE [{id.Name}] = @{id.Name};");
        sb.AppendLine("END");

        return sb.ToString();
    }
    static string GenerateDeleteHard(string schema, string table, List<DbColumn> cols)
    {
        var id = cols.First(c => c.IsIdentity);

        var sb = new StringBuilder();
        sb.AppendLine($"CREATE OR ALTER PROCEDURE [{schema}].[sp_{table}_Delete]");
        sb.AppendLine($"    @{id.Name} {DbSchemaReader.GetSqlType(id)}");
        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine("    SET NOCOUNT ON;");
        sb.AppendLine();
        sb.AppendLine($"    DELETE FROM [{schema}].[{table}]");
        sb.AppendLine($"    WHERE [{id.Name}] = @{id.Name};");
        sb.AppendLine("END");

        return sb.ToString();
    }
    static string GenerateDeleteSoft(string schema, string table, List<DbColumn> cols)
    {
        var id = cols.First(c => c.IsIdentity);
        var hasIsActive = cols.Any(c => c.IsIsActive());

        if (!hasIsActive)
            return ""; // tablo soft delete desteklemiyor

        var sb = new StringBuilder();
        sb.AppendLine($"CREATE OR ALTER PROCEDURE [{schema}].[sp_{table}_DeleteSoft]");
        sb.AppendLine($"    @{id.Name} {DbSchemaReader.GetSqlType(id)}");
        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine("    SET NOCOUNT ON;");
        sb.AppendLine();
        sb.AppendLine($"    UPDATE [{schema}].[{table}]");
        sb.AppendLine("    SET [IsActive] = 0");
        sb.AppendLine($"    WHERE [{id.Name}] = @{id.Name};");
        sb.AppendLine("END");

        return sb.ToString();
    }
    static string GenerateGetById(string schema, string table, List<DbColumn> cols)
    {
        var id = cols.First(c => c.IsIdentity);
        var hasIsActive = cols.Any(c => c.IsIsActive());

        var sb = new StringBuilder();
        sb.AppendLine($"CREATE OR ALTER PROCEDURE [{schema}].[sp_{table}_GetById]");
        sb.AppendLine($"    @{id.Name} {DbSchemaReader.GetSqlType(id)}");
        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine("    SET NOCOUNT ON;");
        sb.AppendLine();
        sb.AppendLine($"    SELECT * FROM [{schema}].[{table}]");
        sb.AppendLine($"    WHERE [{id.Name}] = @{id.Name}");

        if (hasIsActive)
            sb.AppendLine("      AND IsActive = 1");

        sb.AppendLine("END");

        return sb.ToString();
    }
    static string GenerateList(string schema, string table, List<DbColumn> cols)
    {
        var hasIsActive = cols.Any(c => c.IsIsActive());

        var sb = new StringBuilder();
        sb.AppendLine($"CREATE OR ALTER PROCEDURE [{schema}].[sp_{table}_List]");
        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine("    SET NOCOUNT ON;");
        sb.AppendLine();
        sb.AppendLine($"    SELECT * FROM [{schema}].[{table}]");

        if (hasIsActive)
            sb.AppendLine("    WHERE IsActive = 1");

        sb.AppendLine("END");

        return sb.ToString();
    }

    static string GeneratePagedList(string schema, string table, List<DbColumn> cols)
    {
        var id = cols.First(c => c.IsIdentity);
        var hasIsActive = cols.Any(c => c.IsIsActive());

        var sb = new StringBuilder();
        sb.AppendLine($"CREATE OR ALTER PROCEDURE [{schema}].[sp_{table}_PagedList]");
        sb.AppendLine("    @Page INT,");
        sb.AppendLine("    @PageSize INT");
        sb.AppendLine("AS");
        sb.AppendLine("BEGIN");
        sb.AppendLine("    SET NOCOUNT ON;");
        sb.AppendLine();
        sb.AppendLine($"    SELECT * FROM [{schema}].[{table}]");

        if (hasIsActive)
            sb.AppendLine("    WHERE IsActive = 1");

        sb.AppendLine($"    ORDER BY [{id.Name}] DESC");
        sb.AppendLine("    OFFSET (@Page - 1) * @PageSize ROWS");
        sb.AppendLine("    FETCH NEXT @PageSize ROWS ONLY;");
        sb.AppendLine();
        sb.AppendLine("    SELECT COUNT(1) AS TotalCount");
        sb.AppendLine($"    FROM [{schema}].[{table}]");

        if (hasIsActive)
            sb.AppendLine("    WHERE IsActive = 1");

        sb.AppendLine("END");

        return sb.ToString();
    }



}