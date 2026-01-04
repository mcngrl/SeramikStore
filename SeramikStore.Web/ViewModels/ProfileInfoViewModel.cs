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

    public string Email { get; set; } 

    public string PhoneNumber { get; set; }

    [DataType(DataType.Date)]
    public DateTime? BirthDate { get; set; }
}
