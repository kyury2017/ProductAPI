using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Model;
using WebAPIProducts.Data;
using WebAPIProducts.Models;
using System.Linq;


namespace WebAPIProducts.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductVersionController : ControllerBase
    {
        private readonly ServiceData.IData _context;

        public ProductVersionController(ServiceData.IData context)
        {
            _context = context;
        }
        // GET: api/<ProductVersionController>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Model.ProductVersion>>> Get()
        {
            return await _context.ProductVersionsGet();
        }

        // GET api/<ProductVersionController>/5
        [HttpGet("{productID}")]
        public async Task<ActionResult<IEnumerable<Model.ProductVersion>>> Get(Guid productID)
        {
            return await _context.ProductVersionsGet(productID);
        }

        // POST api/<ProductVersionController>
        [HttpPost]
        public async Task<ActionResult<Model.ProductVersion>> Post(ProductVersion productVersion)
        {
            return await _context.ProductVersionAdd(productVersion);
        }

        // PUT api/<ProductVersionController>/5
        [HttpPut("{id}")]
        public async Task<ActionResult<Model.ProductVersion>> Put(Guid id, ProductVersion productVersion)
        {
            if (id != productVersion.ID)
            {
                return BadRequest();
            }
            return await _context.ProductVersionChenge(productVersion);
        }

        // DELETE api/<ProductVersionController>/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<bool>> Delete(Guid id)
        {
            return await _context.ProductVertionDelete(id);
        }
    }
}
