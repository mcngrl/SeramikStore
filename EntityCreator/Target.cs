using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityCreator
{
    public class Target
    {

        public string Namespace { get; set; }
        public string ContractNamespace { get; set; }
        public string ServiceNamespace { get; set; }
        public string ContractsNamespace { get; set; }
        public string ViewModelNamespace { get; set; }
        public string ControllerNamespace { get; set; }

        public string ConnectionString { get; set; }
        public string _solutionRoot { get; set; }
        public string ProjectName { get; set; }
        private string _folderName { get; set; }
        public string WelcomeText { get; set; }

        private string _fileExtension { get; set; }
        public int OrderNo { get; set; }

        private string _tableName;
        public string TableName
        {
            get
            {
                // Buraya GET sırasında çalışacak kodu yazabilirsin
                return _tableName;
            }
            set
            {
                _tableName = value;
                FileFullPath = Path.Combine(_folderName, $"{_tableName}{_fileExtension}");
                ContractNamespace = $"SeramikStore.Contracts.{_tableName}";
                ServiceNamespace = $"SeramikStore.Services";
                ViewModelNamespace = $"SeramikStore.Web.ViewModels.{_tableName}";
                ControllerNamespace = $"SeramikStore.Web.Controllers";
                ContractNamespace = $"SeramikStore.Contracts.{_tableName}";
  

                if (_NameSpacewithEntityname)
                {
                    Namespace = $"{ProjectName}.{_tableName}"; 
                }
                else
                {
                    Namespace = $"{ProjectName}";
                }
                    
            }
        }
        private bool _NameSpacewithEntityname { get; set; }

        public string FileFullPath { get; set; }

        public ITargetAction Action { get; set; }

        public Target(int orderNo,string solutionRoot, string projectName, 
            bool NameSpacewithEntityname, string fileExtension, ITargetAction action)
        {
            _solutionRoot = solutionRoot;
            ProjectName= projectName;

            _folderName = Path.Combine(solutionRoot, projectName);
            WelcomeText = $"ADIM {orderNo} {projectName}";

            OrderNo = orderNo;
            _NameSpacewithEntityname = NameSpacewithEntityname;
            _fileExtension = fileExtension;

          
            
            Action = action;
        }

        public void Execute()
        {
            if (Action == null)
                throw new InvalidOperationException("Target Action tanımlı değil.");

            Action.Execute(this);
        }
    }
}
