using Microsoft.AspNetCore.Mvc;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;

namespace SeramikStore.Web.Controllers.Api
{
    [Route("api/product-order")]
    [ApiController]
    public class ProductOrderApiController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductOrderApiController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpPost("update")]
        public IActionResult UpdateOrder([FromBody] List<ProductOrderDto> list)
        {
            //if (!ModelState.IsValid)
            //    return BadRequest(ModelState);


            //if (list == null || !list.Any())
            //    return BadRequest();

            _productService.UpdateDisplayOrder(list);

            return Ok(new { success = true });
        }
    }
}
