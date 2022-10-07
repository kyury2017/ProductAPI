using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using WebAPIProducts.Models;

namespace WebAPIProducts.Data
{
    public class WebAPIProductsContext : DbContext
    {
        public WebAPIProductsContext (DbContextOptions<WebAPIProductsContext> options)
            : base(options)
        {
        }

        public DbSet<WebAPIProducts.Models.Product> Product { get; set; } = default!;
    }
}
