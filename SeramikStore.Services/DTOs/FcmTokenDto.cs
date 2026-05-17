using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services.DTOs
{
    public class FcmTokenDto
    {
        public string Token { get; set; } = null!;
        public string UserAgent { get; set; } = null!;
        public string DeviceName { get; set; } = null!;
    }
}
