using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using WebAPIProducts.Models;

namespace WebAPIProducts.Data
{
    public class Context : IContext
    {
        WebAPIProductsContext _condb;
        #region IContext
        IList<Product> IContext.GetProducts()
        {
            return this.GetProducts();
        }

        IList<Product> IContext.GetProducts(string name)
        {
            return this.GetProducts(name);
        }

        Product IContext.AddProduct(Product product)
        {
            return this.AddProduct(product);
        }

        Product IContext.ChangeProduct(Guid id, Product product)
        {
            return this.ChangeProduct(id, product);
        }
        bool IContext.DeleteProduct(Guid id)
        {
            return this.DeleteProduct(id);
        }
        #endregion//IContext

        #region Constructors
        
        public Context(Microsoft.EntityFrameworkCore.DbContextOptions<WebAPIProductsContext> options)
        {
            _condb = new WebAPIProductsContext(options); 
        }
        
        #endregion//Constructors
        #region Helper Methods

        private IList<Product> GetProducts()
        {
            try
            {
                return _condb.Product.ToList<Product>();
            }
            catch
            {
                throw;
            }
        }
        private IList<Product> GetProducts(string name)
        {
            try
            {
                return _condb.Product.Where(w => EF.Functions.Like(w.Name, string.Format("%{0}%", name))).ToList<Product>();
            }
            catch
            {

                throw;
            }
        }

        private Product AddProduct(Product product)
        {
            try
            {
                if (product == null)
                    throw new ArgumentNullException();
                _condb.Product.Add(product);
                _condb.SaveChanges();
                return product;
            }
            catch 
            {

                throw;
            } 
        }

        private Product ChangeProduct(Guid id, Product product)
        {
            if (id != product.ID)
            {
                throw new ArgumentException();
            }
            _condb.Entry(product).State = EntityState.Modified;
            try
            {
                int i= _condb.SaveChanges();
                return product;
            }
            catch
            {

                throw;
            }
        }

        private bool DeleteProduct(Guid id)
        {
            try
            {
                var product = _condb.Product.Find(id);
                if (product == null)
                {
                    throw new Exception("Not find product.");
                }
                _condb.Product.Remove(product);
                int i = _condb.SaveChanges();
                if (i == 0)
                    return false;
                return true;
            }
            catch
            {
                throw;
            }
        }

        async Task GetProductAsync()
        {
            await Task.Run(() => this.GetProducts());
        }

       




        #endregion//Helper Methods
    }
}
