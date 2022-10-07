using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using WebAPIProducts.Data;
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<WebAPIProductsContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("WebAPIProductsContext") ?? throw new InvalidOperationException("Connection string 'WebAPIProductsContext' not found.")));

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
//builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    //app.UseSwagger();
    //app.UseSwaggerUI();
}
else
{
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
