using SeramikStore.Contracts.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface IAppLogService
    {
        Task InfoAsync(string module, string action, string message);
        Task SuccessAsync(string module, string action, string messagel);
        Task WarningAsync(string module, string action, string message);
        Task ErrorAsync(string module, string action, string message,Exception ex = null);

        List<AppLogDto> GetRecent(int take = 200);
    }

}
