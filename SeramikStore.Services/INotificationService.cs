using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface INotificationService
    {
        Task SendToAdmin(string title, string body);
    }
}
