using Microsoft.Data.SqlClient;
using System;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;

class Scripter
{
    public static void Main(string? connectionString)
    {
  
        string outputFile = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.Desktop),
            "FullDatabaseScript.sql");

        using var conn = new SqlConnection(connectionString);
        conn.Open();

        using var writer = new StreamWriter(
            outputFile,
            false,
            new UTF8Encoding(encoderShouldEmitUTF8Identifier: true),
            bufferSize: 1024 * 1024);

        writer.WriteLine("-- ===============================================");
        writer.WriteLine("-- FULL DATABASE SCRIPT");
        writer.WriteLine($"-- Generated: {DateTime.Now}");
        writer.WriteLine("-- ===============================================");
        writer.WriteLine();

        var tables = GetTables(conn);

        foreach (DataRow row in tables.Rows)
        {
            string schema = row["TABLE_SCHEMA"].ToString();
            string table = row["TABLE_NAME"].ToString();

            writer.WriteLine($"-- ===============================");
            writer.WriteLine($"-- {schema}.{table}");
            writer.WriteLine($"-- ===============================");

            WriteDropCreateTable(conn, writer, schema, table);
            WriteInsertData(conn, writer, schema, table);
            writer.WriteLine();
        }

        writer.WriteLine();
        writer.WriteLine("-- ===============================");
        writer.WriteLine("-- STORED PROCEDURES");
        writer.WriteLine("-- ===============================");

        WriteStoredProcedures(conn, writer);

        Console.WriteLine("✔ Script oluşturuldu:");
        Console.WriteLine(outputFile);
    }

    // ===================== TABLE LIST =====================
    static DataTable GetTables(SqlConnection conn)
    {
        var dt = new DataTable();
        string sql = @"
            SELECT TABLE_SCHEMA, TABLE_NAME
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_TYPE = 'BASE TABLE'
            ORDER BY TABLE_SCHEMA, TABLE_NAME";

        using var da = new SqlDataAdapter(sql, conn);
        da.Fill(dt);
        return dt;
    }

    // ===================== DROP / CREATE TABLE =====================
    static void WriteDropCreateTable(SqlConnection conn, TextWriter writer, string schema, string table)
    {
        writer.WriteLine($@"
IF OBJECT_ID('{schema}.{table}', 'U') IS NOT NULL
    DROP TABLE [{schema}].[{table}]
GO
CREATE TABLE [{schema}].[{table}] (");

        string colSql = @"
            SELECT
                c.name AS ColumnName,
                t.name AS DataType,
                c.max_length,
                c.precision,
                c.scale,
                c.is_nullable,
                c.is_identity
            FROM sys.columns c
            JOIN sys.types t ON c.user_type_id = t.user_type_id
            WHERE c.object_id = OBJECT_ID(@TableName)
            ORDER BY c.column_id";

        using var cmd = new SqlCommand(colSql, conn);
        cmd.Parameters.AddWithValue("@TableName", $"{schema}.{table}");

        using var rdr = cmd.ExecuteReader();

        bool first = true;

        while (rdr.Read())
        {
            if (!first) writer.WriteLine(",");
            first = false;

            string col = rdr["ColumnName"].ToString();
            string type = rdr["DataType"].ToString();
            short maxLength = (short)rdr["max_length"];
            byte precision = (byte)rdr["precision"];
            byte scale = (byte)rdr["scale"];
            bool nullable = (bool)rdr["is_nullable"];
            bool identity = (bool)rdr["is_identity"];

            writer.Write($"   [{col}] {type}");

            if (type is "varchar" or "nvarchar" or "char" or "nchar")
                writer.Write(maxLength == -1 ? "(MAX)" : $"({maxLength})");
            else if (type is "decimal" or "numeric")
                writer.Write($"({precision},{scale})");

            if (identity)
                writer.Write(" IDENTITY(1,1)");

            writer.Write(nullable ? " NULL" : " NOT NULL");
        }

        writer.WriteLine();
        writer.WriteLine(")");
        writer.WriteLine("GO");
    }

    // ===================== INSERT DATA (FAST) =====================
    static void WriteInsertData(SqlConnection conn, TextWriter writer, string schema, string table)
    {
        var columns = new DataTable();
        string colSql = @"
        SELECT 
            c.name AS ColumnName,
            t.name AS DataType,
            c.is_identity
        FROM sys.columns c
        JOIN sys.types t ON c.user_type_id = t.user_type_id
        WHERE c.object_id = OBJECT_ID(@TableName)
        ORDER BY c.column_id";

        using (var da = new SqlDataAdapter(colSql, conn))
        {
            da.SelectCommand.Parameters.AddWithValue("@TableName", $"{schema}.{table}");
            da.Fill(columns);
        }

        bool hasIdentity = columns.AsEnumerable().Any(r => (bool)r["is_identity"]);

        using var cmd = new SqlCommand($"SELECT * FROM [{schema}].[{table}]", conn);
        using var rdr = cmd.ExecuteReader();

        if (!rdr.HasRows)
            return;

        if (hasIdentity)
            writer.WriteLine($"SET IDENTITY_INSERT [{schema}].[{table}] ON");

        string columnList = string.Join(", ",
            columns.AsEnumerable().Select(c => $"[{c["ColumnName"]}]"));

        bool firstRow = true;
        bool open = false;

        while (rdr.Read())
        {
            if (!open)
            {
                writer.WriteLine($"INSERT INTO [{schema}].[{table}] ({columnList})");
                writer.WriteLine("VALUES");
                open = true;
                firstRow = true;
            }

            if (!firstRow)
                writer.WriteLine(",");

            writer.Write("(");

            for (int i = 0; i < columns.Rows.Count; i++)
            {
                object val = rdr.GetValue(i);
                string type = columns.Rows[i]["DataType"].ToString();

                if (val == DBNull.Value)
                {
                    writer.Write("NULL");
                }
                else if (val is DateTime dt)
                {
                    // ✅ ISO 8601 – SQL Server safe
                    writer.Write($"'{dt:yyyy-MM-ddTHH:mm:ss}'");
                }
                else if (val is string s)
                {
                    string safe = s.Replace("'", "''");

                    if (type is "nvarchar" or "nchar" or "ntext")
                        writer.Write($"N'{safe}'");
                    else
                        writer.Write($"'{safe}'");
                }
                else if (val is bool b)
                {
                    writer.Write(b ? "1" : "0");
                }
                else
                {
                    writer.Write(Convert.ToString(val, CultureInfo.InvariantCulture));
                }

                if (i < columns.Rows.Count - 1)
                    writer.Write(", ");
            }

            writer.Write(")");
            firstRow = false;
        }

        if (open)
        {
            writer.WriteLine();
            writer.WriteLine("GO");
        }

        if (hasIdentity)
            writer.WriteLine($"SET IDENTITY_INSERT [{schema}].[{table}] OFF");
    }


    // ===================== STORED PROCEDURES =====================
    static void WriteStoredProcedures(SqlConnection conn, TextWriter writer)
    {
        string sql = @"
            SELECT 
                s.name AS SchemaName,
                p.name AS ProcedureName,
                m.definition
            FROM sys.procedures p
            JOIN sys.schemas s ON p.schema_id = s.schema_id
            JOIN sys.sql_modules m ON p.object_id = m.object_id
            ORDER BY s.name, p.name";

        using var cmd = new SqlCommand(sql, conn);
        using var rdr = cmd.ExecuteReader();

        while (rdr.Read())
        {
            string schema = rdr["SchemaName"].ToString();
            string name = rdr["ProcedureName"].ToString();
            string def = rdr["definition"].ToString();

            writer.WriteLine($"-- {schema}.{name}");
            writer.WriteLine($@"
IF OBJECT_ID('{schema}.{name}', 'P') IS NOT NULL
    DROP PROCEDURE [{schema}].[{name}]
GO");

            if (def.TrimStart().StartsWith("ALTER", StringComparison.OrdinalIgnoreCase))
                def = "CREATE" + def.Substring(5);

            writer.WriteLine(def);
            writer.WriteLine("GO");
            writer.WriteLine();
        }
    }
}
