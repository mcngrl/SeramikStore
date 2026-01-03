using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services.DTOs
{
    public class LoginDto
    {
        public string Email { get; set; }
        public string PasswordPlaintext { get; set; }
    }

}
