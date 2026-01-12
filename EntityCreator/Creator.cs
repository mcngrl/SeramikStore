using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityCreator
{
    public class Creator
    {
        public static void Main(string? connectionString, string schema, string table, string className , string strnamespace, string outputFile)
        {

            var columns = DbSchemaReader.GetColumns(
            connectionString, schema, table);

            string entityCode = EntityWriter.GenerateEntity(
            strnamespace,
            className,
            columns);

            File.WriteAllText(outputFile, entityCode);
        }


    }
}
