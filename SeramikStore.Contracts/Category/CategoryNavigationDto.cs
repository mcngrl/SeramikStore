
using System;

namespace SeramikStore.Contracts.Category
{
    public class CategoryNavigationDto
    {
        public int SelectedCategoryId { get; set; }
        public List<CategoryListItemDto> List { get; set; }
    }
}
