using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Entities
{
    public class AuthenticatedUser
    {
        [Required]
        public int Id { get; set; }

        [Required]
        public string UserName { get; set; }


        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }


        [Required] // Gereklidir
        [DataType(DataType.Password)] // Veri türü: Parola
        [Display(Name = "Parolayı onaylayın")] // Görüntüleme adı: Parolayı onaylayın
        [Compare("Password", ErrorMessage = "Parola ve onay parolası eşleşmiyor.")] // Parola ve onay parolası karşılaştırması, hata mesajı: Parola ve onay parolası eşleşmiyor.
        public string ConfirmPassword { get; set; }


        public string Name { get; set; }
        public string Email { get; set; }
        public string TelephoneNumber { get; set; }
        public string Address { get; set; }
        public int RoleId { get; set; }

    }
}
