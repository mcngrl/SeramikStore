using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Microsoft.AspNetCore.Mvc.Rendering;
using SeramikStore.Entities;

namespace SeramikStore.Web.ViewModels
{
    public class ProductCreateViewModel
    {
        public Product Product { get; set; }


        [ValidateNever]
        public List<SelectListItem> Currencies { get; set; }
        // public List<Category> Categories { get; set; }
    }

}
