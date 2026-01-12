using Microsoft.Data.SqlClient;
using System.Data;
using System.Data.Common;

public static class DbSchemaReader
{
    public static List<DbColumn> GetColumns(
        string connectionString,
        string schema,
        string table)
    {
        var list = new List<DbColumn>();

        using SqlConnection conn = new(connectionString);
        using SqlCommand cmd = new(@"SELECT
            c.name AS ColumnName,
            t.name AS DataType,
            c.max_length,
            c.precision,
            c.scale,
            c.is_nullable,
            c.is_identity
            FROM sys.columns c
            JOIN sys.types t ON c.user_type_id = t.user_type_id
            WHERE c.object_id = OBJECT_ID(@Table)
            ORDER BY c.column_id", conn);

        cmd.Parameters.AddWithValue("@Table", $"{schema}.{table}");
        conn.Open();

        using SqlDataReader rdr = cmd.ExecuteReader();
        while (rdr.Read())
        {
            list.Add(new DbColumn
            {
                Name = rdr["ColumnName"].ToString(),
                SqlType = rdr["DataType"].ToString(),
                MaxLength = Convert.ToInt32(rdr["max_length"]),
                Precision = Convert.ToByte(rdr["precision"]),
                Scale = Convert.ToByte(rdr["scale"]),
                IsNullable = (bool)rdr["is_nullable"],
                IsIdentity = (bool)rdr["is_identity"]
            });
        }
        return list;
    }

    public static string GetSqlType(DbColumn c)
    {
        if (c.SqlType is "nvarchar" or "nchar")
            return c.MaxLength == -1
                ? $"{c.SqlType}(MAX)"
                : $"{c.SqlType}({c.MaxLength / 2})";

        if (c.SqlType is "varchar" or "char")
            return c.MaxLength == -1
                ? $"{c.SqlType}(MAX)"
                : $"{c.SqlType}({c.MaxLength})";

        if (c.SqlType is "decimal" or "numeric")
            return $"{c.SqlType}({c.Precision},{c.Scale})";

        return c.SqlType;
    }
}
