using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface IFcmService
    {
        void SaveToken(string token, string userAgent, string deviceName, string userName);
    }
}
