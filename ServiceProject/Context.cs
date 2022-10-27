using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataApi
{
    public class Context : DbContext
    {
        public Context(DbContextOptions<Context> options)
            : base(options)
        {
        }

        public DbSet<Model.Product> Product { get; set; } = default!;
        public DbSet<Model.ProductVersion> ProductVersion { get; set; } = default!;
        public DbSet<Model.EventLog> EventLog { get; set; } = default!;
    }
}
