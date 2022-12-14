using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
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

namespace WebAPIProducts.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly DataApi.IData _context;
        public ProductsController(DataApi.IData context)
        {
            _context = context;
        }
        [HttpPost()]
        [Route("Find")]
        public async Task<ActionResult<IEnumerable<Model.Product>>> Find(
            [FromBody(EmptyBodyBehavior = Microsoft.AspNetCore.Mvc.ModelBinding.EmptyBodyBehavior.Allow)]string name)
        {
            if (string.IsNullOrEmpty(name)) 
            { return await _context.ProductsGet(); }
            else 
            { return await _context.ProductsGet(name); }
        }
        // PUT: api/Products/5
        [HttpPut("{id}")]
        public async Task<ActionResult<Model.Product>> PutProduct(Model.Product product)
        {
            if (product == null)
                return BadRequest();
            try
            {
                return await _context.ProductChenge(product);
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

        // POST: api/Products
        [HttpPost]
        public async Task<ActionResult<Model.Product>> PostProduct(Model.Product product)
        {
            if (product == null)
                return BadRequest();
            try
            {
                return await _context.ProductAdd(product);
            }
            catch (DbUpdateConcurrencyException)
            {
                    return Conflict();
            }
        }
        // DELETE: api/Products/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteProduct(Guid id)
        {
            try
            {
                var result = await _context.ProductDelete(id);
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
/*
    using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebAPIProducts.Data;
using WebAPIProducts.Models;

namespace WebAPIProducts.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly WebAPIProductsContext _context;
        private readonly ILogger _logger;
        public ProductsController(WebAPIProductsContext context, ILogger<ProductsController> logger)
        {
            _context = context;
            _logger = logger;
        }

        // GET: api/Products
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Product>>> GetProduct()
        {
            try
            {
                var result= await _context.Product.ToListAsync();
                int count = result==null? 0:result.Count;
                string mess = string.Format("{0} Product Objects Selected - {1}", count, DateTime.UtcNow.ToLongTimeString());
                _logger.LogInformation(mess);
                return result;
            }
            catch
            {
#if DEBUG
                throw;
#else
                return this.StatusCode(404);
#endif 
            }
        }
       
        // GET: api/Products/5
        [HttpGet("{name}")]
        public async Task<ActionResult<List<Product>>> GetProduct(string name)
        {
            try
            {
                var result = await _context.Product.Where(w => EF.Functions.Like(w.Name, string.Format("%{0}%", name))).ToListAsync();
                int count = result == null ? 0 : result.Count;
                string mess = string.Format("{0} Product Objects Selected - {1}", count, DateTime.UtcNow.ToLongTimeString());
                _logger.LogInformation(mess);

                if (result == null || result.Count == 0)
                {
                    return NotFound();
                }

                return result;
            }
            catch
            {
#if DEBUG
                throw;
#else
                return this.StatusCode(404);
#endif 
            }
        }

        // PUT: api/Products/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProduct(Guid id, Product product)
        {
            if (id != product.ID)
            {
                return BadRequest();
            }
            _context.Entry(product).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
                string mess = string.Format("Changed product with an identifier - {0}\t{1}", id, DateTime.UtcNow.ToLongTimeString());
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Product.Any(a=>a.ID==id))
                {
                    return NotFound();
                }
                else
                {
#if DEBUG
                    throw;
#else
                    return this.StatusCode(404);
#endif 
                }
            }

            return NoContent();
        }

        // POST: api/Products
        [HttpPost]
        public async Task<ActionResult<Product>> PostProduct(Product product)
        {
            try
            {
                if (product == null)
                    throw new ArgumentNullException();
                _context.Product.Add(product);
                await _context.SaveChangesAsync();
                string mess = string.Format("Added product with an identifier - {0}\t{1}", product.ID, DateTime.UtcNow.ToLongTimeString());
                return CreatedAtAction("GetProduct", new { id = product.ID }, product);
            }
            catch
            {
#if DEBUG
                throw;
#else
                return this.StatusCode(404);
#endif
            }
        }

        // DELETE: api/Products/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(Guid id)
        {
            try
            {
                var product = await _context.Product.FindAsync(id);
                if (product == null)
                {
                    return NotFound();
                }

                _context.Product.Remove(product);
                await _context.SaveChangesAsync();
                string mess = string.Format("Deleted product with an identifier - {0}\t{1}", product.ID, DateTime.UtcNow.ToLongTimeString());
                return NoContent();
            }
            catch
            {
#if DEBUG
                throw;
#else
                return this.StatusCode(404);
#endif 
            }

        }
    }
}
 
 */
