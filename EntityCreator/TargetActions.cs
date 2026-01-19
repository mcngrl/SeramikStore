using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityCreator
{
    public class EntityAction : ITargetAction
    {
        public void Execute(Target target)
        {

            var columns = DbSchemaReader.GetColumns(target.ConnectionString, "dbo", target.TableName);

            string fileContent = EntityWriter.GenerateEntity(
             target.Namespace,
             target.TableName,
            columns);

            File.WriteAllText(target.FileFullPath, fileContent);


        }
    }

    public class CrudSpAction : ITargetAction
    {
        public void Execute(Target target)
        {
            var columns = DbSchemaReader.GetColumns(target.ConnectionString, "dbo", target.TableName);

            string fileContent = SpWriter.GenerateCrudSp(
            "dbo",
            target.TableName,
            columns);

            File.WriteAllText(target.FileFullPath, fileContent);

        }
    }

    public class DtoAction : ITargetAction
    {
        public void Execute(Target target)
        {
            var columns = DbSchemaReader.GetColumns(
                target.ConnectionString,
                "dbo",
                target.TableName);

            var folder = Path.Combine(
                target._solutionRoot,
                "SeramikStore.Contracts",
                target.TableName);

            Directory.CreateDirectory(folder);

            var files = DtoWriter.GenerateDtos(
                $"SeramikStore.Contracts.{target.TableName}",
                target.TableName,
                columns);

            foreach (var file in files)
            {
                File.WriteAllText(
                    Path.Combine(folder, file.Key),
                    file.Value);
            }
        }
    }

    public class ServiceAction : ITargetAction
    {
        public void Execute(Target target)
        {
            var columns = DbSchemaReader.GetColumns(
                target.ConnectionString, "dbo", target.TableName);

            var folder = Path.Combine(
                target._solutionRoot,
                "SeramikStore.Services",
                target.TableName);

            Directory.CreateDirectory(folder);

            // Interface
            File.WriteAllText(
                Path.Combine(folder, $"I{target.TableName}Service.generated.cs"),
                ServiceWriter.GenerateServiceInterface(
                    target.Namespace,
                    target.ContractNamespace,
                    target.TableName));

            // Implementation
            File.WriteAllText(
                Path.Combine(folder, $"{target.TableName}Service.generated.cs"),
                ServiceWriter.GenerateServiceImplementation(
                    target.Namespace,
                    target.ContractNamespace,
                    target.TableName,
                    columns));
        }
    }

    public class ViewModelAction : ITargetAction
    {
        public void Execute(Target target)
        {
            var columns = DbSchemaReader.GetColumns(
                target.ConnectionString,
                "dbo",
                target.TableName);

            var folder = Path.Combine(
                target._solutionRoot,
                @"SeramikStore.Web\ViewModels",
                target.TableName);

            Directory.CreateDirectory(folder);

            var files = ViewModelWriter.GenerateViewModels(
                $"SeramikStore.Web.ViewModels.{target.TableName}",
                target.TableName,
                columns);

            foreach (var file in files)
            {
                File.WriteAllText(
                    Path.Combine(folder, file.Key),
                    file.Value);
            }
        }
    }

    public class ControllerAction : ITargetAction
    {
        public void Execute(Target target)
        {

            string fileContent = ControllerWriter.GenerateController(
                target.ControllerNamespace,
                target.TableName,
                target.ServiceNamespace,
                target.ViewModelNamespace,
                target.ContractNamespace
             );

            File.WriteAllText(target.FileFullPath, fileContent);


        }
    }


 
    public class ViewAction : ITargetAction
    {
        public void Execute(Target target)
        {
            var columns = DbSchemaReader.GetColumns(
                target.ConnectionString,
                "dbo",
                target.TableName);

            var folder = Path.Combine(
                target._solutionRoot,
                "SeramikStore.Web\\Views",
                target.TableName);

            Directory.CreateDirectory(folder);

            var files = ViewWriter.GenerateViews(
                target.TableName,
                $"SeramikStore.Web.ViewModels.{target.TableName}",
                columns);

            foreach (var file in files)
            {
                File.WriteAllText(
                    Path.Combine(folder, file.Key),
                    file.Value);
            }
        }
    }
}
