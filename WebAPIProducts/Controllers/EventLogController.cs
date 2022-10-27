using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace WebAPIProducts.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventLogController : ControllerBase
    {
        private readonly DataApi.IData _context;
        public EventLogController(DataApi.IData context)
        {
            _context = context;
        }
        // GET: api/<EventLogController>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Model.EventLog>>> Get()
        {
            return await _context.EventLogGet();
        }
    }
}
