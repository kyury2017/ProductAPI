using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//using Microsoft.AspNetCore.Mvc;

namespace ServiceData
{
    public class Data : IData
    {
        Context context;
        public Data(string connectionString)
        {
            var optionsBuilder = new DbContextOptionsBuilder<Context>();
            DbContextOptions<Context> options = optionsBuilder.UseSqlServer(connectionString).Options;
            context = new Context(options);
        }


        #region IServiceData
        Task<ActionResult<Product>> IData.ProductAdd(Product product)
        {
            return this.ProductAdd(product);
        }
        Task<ActionResult<Product>> IData.ProductChenge(Product product)
        {
            return this.ProductChenge(product);
        }
        Task<ActionResult<bool>> IData.ProductDelete(Guid id)
        {
            return this.ProductDelete(id);
        }
        Task<ActionResult<IEnumerable<Product>>> IData.ProductsGet()
        {
            return this.ProductsGet();
        }
        Task<ActionResult<IEnumerable<Product>>> IData.ProductsGet(string name)
        {
            return this.ProductsGet(name);
        }

        Task<ActionResult<IEnumerable<Model.ProductVersion>>> IData.ProductVersionsGet()
        {
            return this.ProductVersionsGet();
        }



        Task<ActionResult<IEnumerable<Model.ProductVersion>>> IData.ProductVersionsGet(Guid productID)
        {
            return this.ProductVersionsGet(productID);
        }



        Task<ActionResult<Model.ProductVersion>> IData.ProductVersionAdd(ProductVersion productVersion)
        {
            return this.ProductVersionAdd(productVersion);
        }

       Task<ActionResult<Model.ProductVersion>> IData.ProductVersionChenge(ProductVersion productVersion)
        {
            return this.ProductVersionChenge(productVersion);
        }

        Task<ActionResult<bool>> IData.ProductVertionDelete(Guid id)
        {
            return this.ProductVertionDelete(id);
        }



        Task<ActionResult<IEnumerable<EventLog>>> IData.EventLogGet()
        {
            return this.EventLogGet();
        }

        #endregion//IServiceProduct

        #region Helper methods
        private async Task<ActionResult<Product>> ProductAdd(Product product)
        {
            try
            {
                if (product == null)
                    throw new ArgumentNullException();
                context.Product.Add(product);
                await context.SaveChangesAsync();
                return new ActionResult<Product>(new Product()
                {
                    ID = product.ID,
                    Name = product.Name,
                    Description = product.Description
                });
            }
            catch
            {
                throw;
            }
        }

        private async Task<ActionResult<Product>> ProductChenge(Product product)
        {
            try
            {
                context.Entry(product).State = EntityState.Modified;
                await context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!context.Product.Any(a => a.ID == product.ID))
                {
                    return new ActionResult<Product>(new NotFoundResult());
                }
                else
                {
                    throw;
                }
            }

            return new ActionResult<Product>(product);
        }
        private async Task<ActionResult<bool>> ProductDelete(Guid id)
        {
            try
            {
                var product = context.Product.Find(id);
                if (product == null)
                {
                    throw new Exception("Product with ID not find.");
                }
                context.Product.Remove(product);
                
                int count= await context.SaveChangesAsync();
                return new ActionResult<bool>(Convert.ToBoolean(count));
            }
            catch
            {
                throw;
            }
        }

        private async Task<ActionResult<IEnumerable<Product>>> ProductsGet()
        {
            try
            {
                return await context.Product.ToListAsync();
            }
            catch
            {
                throw;
            }
        }
        private async Task<ActionResult<IEnumerable<Product>>> ProductsGet(string name)
        {
            try
            {
                return await context.Product.Where(w => EF.Functions.Like(w.Name, string.Format("%{0}%", name))).ToListAsync();
            }
            catch
            {
                throw;
            }
        }

        private async Task<ActionResult<IEnumerable<Model.ProductVersion>>> ProductVersionsGet()
        {
            try
            {
                return await context.ProductVersion.ToListAsync<ProductVersion>();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private async Task<ActionResult<IEnumerable<Model.ProductVersion>>> ProductVersionsGet(Guid productID)
        {
            try
            {
                return await context.ProductVersion.Where(w => w.ProductID == productID).ToListAsync();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private async Task<ActionResult<ProductVersion>> ProductVersionAdd(ProductVersion productVersion)
        {
            try
            {
                if (productVersion == null)
                    throw new ArgumentNullException();
                context.ProductVersion.Add(productVersion);
                await context.SaveChangesAsync();
                return new ActionResult<ProductVersion>(new ProductVersion()
                {
                    ID = productVersion.ID,
                    ProductID = productVersion.ProductID,
                    CreatingDate = productVersion.CreatingDate,
                    Description = productVersion.Description,
                    Height = productVersion.Height,
                    Length = productVersion.Length,
                    Name = productVersion.Name,
                    Width = productVersion.Width
                });
            }
            catch
            {
                throw;
            }
        }

        private async Task<ActionResult<ProductVersion>> ProductVersionChenge(ProductVersion productVersion)
        {
            try
            {
                context.Entry(productVersion).State = EntityState.Modified;
                await context.SaveChangesAsync();
                return new ActionResult<ProductVersion>(productVersion);
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!context.ProductVersion.Any(a => a.ID == productVersion.ID))
                {
                    return new ActionResult<ProductVersion>(new NotFoundResult());
                }
                else
                {
                    throw;
                }
            }

            return new ActionResult<ProductVersion>(productVersion);
        }

        private async Task<ActionResult<bool>> ProductVertionDelete(Guid id)
        {
            try
            {
                var productVesion = await context.ProductVersion.FindAsync(id);
                if (productVesion == null)
                {
                    return new ActionResult<bool>(new NotFoundResult()); 
                }
                context.ProductVersion.Remove(productVesion);
                await context.SaveChangesAsync();
                return new ActionResult<bool>(true);
            }
            catch
            {
                throw;
            }

        }
        private async Task<ActionResult<IEnumerable<EventLog>>> EventLogGet()
        {
            try
            {
                return await context.EventLog.ToListAsync();
            }
            catch
            {
                throw;
            }

        }
        #endregion//Helper methods
    }
}
