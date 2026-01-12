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
        using SqlCommand cmd = new(@"
            SELECT
                c.name AS ColumnName,
                t.name AS DataType,
                c.is_nullable,
                c.is_identity
            FROM sys.columns c
            JOIN sys.types t ON c.user_type_id = t.user_type_id
            WHERE c.object_id = OBJECT_ID(@Table)
            ORDER BY c.column_id
        ", conn);

        cmd.Parameters.AddWithValue("@Table", $"{schema}.{table}");
        conn.Open();

        using SqlDataReader rdr = cmd.ExecuteReader();
        while (rdr.Read())
        {
            list.Add(new DbColumn
            {
                Name = rdr["ColumnName"].ToString(),
                SqlType = rdr["DataType"].ToString(),
                IsNullable = (bool)rdr["is_nullable"],
                IsIdentity = (bool)rdr["is_identity"]
            });
        }
        return list;
    }
}
