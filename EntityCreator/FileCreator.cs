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
            schema,
            className,
            columns);

            File.WriteAllText(outputFile, tsqlCode);
        }

        public static void RunDTO(string connectionString, string schema, string table, string className, string strnamespace, string outputFile)
        {

            var columns = DbSchemaReader.GetColumns(
            connectionString, schema, table);

            string tsqlCode = DtoWriter.GenerateDtos(
            strnamespace,
            className,
            columns);

            File.WriteAllText(outputFile, tsqlCode);
        }


        public static void RunService(string connectionString, string schema, string table, string className, string strnamespace, string outputFile)
        {

            var columns = DbSchemaReader.GetColumns(
            connectionString, schema, table);

            string tsqlCode = ServiceWriter.GenerateService(
            strnamespace,
            table,
            columns);

            File.WriteAllText(outputFile, tsqlCode);
        }


    }
}
