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
        public async Task<ActionResult<IEnumerable<Model.ProductVersion>>> GetProductVersion()
        {
            return await _context.ProductVersionsGet();
        }

        // GET api/<ProductVersionController>/5
        [HttpGet("{productID}")]
        public async Task<ActionResult<IEnumerable<Model.ProductVersion>>> GetProductVersion(Guid productID)
        {
            return await _context.ProductVersionsGet(productID);
        }

        // POST api/<ProductVersionController>
        [HttpPost]
        public async Task<ActionResult<Model.ProductVersion>> PostProductVersion(ProductVersion productVersion)
        {
            if (productVersion == null)
                return BadRequest();
            try
            {
                return await _context.ProductVersionAdd(productVersion);
            }
            catch (DbUpdateConcurrencyException ce)
            {
                return Conflict();
            }
        }

        // PUT api/<ProductVersionController>/5
        [HttpPut("{id}")]
        public async Task<ActionResult<Model.ProductVersion>> PutProductVersion(ProductVersion productVersion)
        {
            if (productVersion == null)
                return BadRequest();
            try
            {
                return await _context.ProductVersionChenge(productVersion);
            }
            catch (ArgumentNullException)
            {
                return NotFound();
            }
            catch (DbUpdateConcurrencyException ce)//нарушения параллелизма при сохранении в базе данных. Нарушение параллелизма возникает, когда во время сохранения затрагивается неожиданное количество строк.
            {
                if (ce.Entries.Count != 0)
                    return Conflict();
                else
                    return NotFound();
            }
        }

        // DELETE api/<ProductVersionController>/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<bool>> DeleteProductVersion(Guid id)
        {
            try
            {
                var result = await _context.ProductVertionDelete(id);
                if (result.Value)
                    return Ok();
                else
                    return base.NotFound();
            }
            catch (DbUpdateConcurrencyException ce)
            {
                if (ce.Entries.Count != 0)
                    return Conflict();
                else
                    return NotFound();
            }

        }
    }
}
