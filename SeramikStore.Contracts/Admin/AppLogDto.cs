using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Admin
{
    public class AppLogDto
    {
        public int Id { get; set; }
        public DateTime LogDate { get; set; }
        public string LogLevel { get; set; }
        public string Module { get; set; }
        public string Action { get; set; }
        public string Message { get; set; }
        public string Exception { get; set; }
        public int? UserId { get; set; }
        public string UserName { get; set; }
        public string IpAddress { get; set; }
    }
}
