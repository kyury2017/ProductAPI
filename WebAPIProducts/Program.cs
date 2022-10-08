using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using WebAPIProducts.Data;
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<WebAPIProductsContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("WebAPIProductsContext") ?? throw new InvalidOperationException("Connection string 'WebAPIProductsContext' not found.")));

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/error-local-development");
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();