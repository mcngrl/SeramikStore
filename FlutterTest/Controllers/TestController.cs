using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;



namespace FlutterTest.Controllers
{
    


    [Route("api/[controller]")]
    [ApiController]
    public class TestController : ControllerBase
    {

      
        // GET: api/Test
        [HttpGet]
        //curl -X GET https://localhost:7039/api/Test
        public IActionResult Get()
        {
            //var orders = _orderService.GetAllOrders();

            //return Ok(orders);
            return Ok("GET - Veri getirildicccc");
        }

        // GET: api/Test/5
        [HttpGet("{id}")]
        //curl -X GET https://localhost:7039/api/Test/5
        public IActionResult GasasasetByIsME(int id)
        {
            return Ok($"GET - Id: {id} olan veri getirildi.oldu");
        }

        // POST: api/Test
        //curl -X POST https://localhost:7039/api/Test -H "Content-Type: application/json" -d "\"Merhaba\""
        [HttpPost]
        public IActionResult Post([FromBody] string value)
        {
            return Ok($"POST - Yeni veri eklendi: {value}");
        }

        // PUT: api/Test/5
        [HttpPut("{id}")]
        //curl -X PUT https://localhost:7039/api/Test/5 -H "Content-Type: application/json" -d "\"Güncellendi\""
        public IActionResult Put(int id, [FromBody] string value)
        {
            return Ok($"PUT - Id: {id} olan veri güncellendi. Yeni değer: {value}");
        }

        // DELETE: api/Test/5
        [HttpDelete("{id}")]
        //curl -X DELETE https://localhost:7039/api/Test/5
        public IActionResult Delete(int id)
        {
            return Ok($"DELETE - Id: {id} olan veri silindi");
        }
    }
}
