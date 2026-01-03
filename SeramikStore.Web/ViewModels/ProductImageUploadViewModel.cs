using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

public class ProductImageUploadViewModel
{
    public int ProductId { get; set; }

    [Required]
    public IFormFile ImageFile { get; set; }

    public bool IsMain { get; set; }
    public int DisplayOrder { get; set; }
}
