using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services.DTOs
{
    public class ProductListByCategoryForHomeDto
    {

        public List<ProductListForHomeDto> ProductList { get; set; } = new();
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
        public int ProductCount { get; set; }

    }
}
