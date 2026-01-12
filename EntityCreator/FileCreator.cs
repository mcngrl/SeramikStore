using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityCreator
{
    public class FileCreator
    {
        public static void RunForEntityClass(string connectionString, string schema, string table, string className , string strnamespace, string outputFile)
        {

            var columns = DbSchemaReader.GetColumns(
            connectionString, schema, table);

            string entityCode = EntityWriter.GenerateEntity(
            strnamespace,
            className,
            columns);

            File.WriteAllText(outputFile, entityCode);
        }
    

            public static void RunCRUDSPSql(string connectionString, string schema, string table, string className, string strnamespace, string outputFile)
        {

            var columns = DbSchemaReader.GetColumns(
            connectionString, schema, table);

            string tsqlCode = SpWriter.GenerateCrudSp(
            strnamespace,
            className,
            columns);

            File.WriteAllText(outputFile, tsqlCode);
        }
    }
}
