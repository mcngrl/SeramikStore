using System.ComponentModel.DataAnnotations;

public class ProfileInfoViewModel
{
    public int Id { get; set; }

    [Required]
    [Display(Name = "Ad")]
    public string FirstName { get; set; }

    [Required]
    [Display(Name = "Soyad")]
    public string LastName { get; set; }

    [Display(Name = "Email")]
    public string Email { get; set; }

    [Display(Name = "Telefon Numarası")]
    public string PhoneNumber { get; set; }

    [DataType(DataType.Date)]
    [Display(Name = "Doğum Tarihi")]
    public DateTime? BirthDate { get; set; }
}
