using System.Data;
using System.Data.SqlClient;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

namespace ExampleAPI;

public class Program
{
    public static void Main(string[] args)
    {
        var MyAllowSpecificOrigins = "_MyAllowSubdomainPolicy";

        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddCors(options =>
        {
            options.AddPolicy(name: MyAllowSpecificOrigins,
                policy =>
                {
                    policy.WithOrigins("http://localhost:3000") // TODO: change to the port number that the frontend application runs on
                        .AllowAnyHeader()
                        .AllowAnyMethod();
                });
        });

        var app = builder.Build();

        app.UseCors(MyAllowSpecificOrigins);

        app.MapGet("/products", async (HttpContext httpContext) =>
        {
            string connectionString = builder.Configuration.GetConnectionString("local_database");

            List<Product> products = new List<Product>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("GetProducts", connection);
                command.CommandType = CommandType.StoredProcedure;

                await connection.OpenAsync();

                using (SqlDataReader reader = await command.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        Product product = new Product();
                        product.ProductId = reader.GetInt32(reader.GetOrdinal("productID"));
                        product.ProductName = reader.GetString(reader.GetOrdinal("productName"));
                        product.manufacturer = reader.GetString(reader.GetOrdinal("manufacturer"));
                        product.category = reader.GetString(reader.GetOrdinal("category"));
                        product.expirationDate = reader.GetString(reader.GetOrdinal("expirationDate"));
                        product.price = reader.GetDouble(reader.GetOrdinal("price"));
                        products.Add(product);
                    }
                }
            }

            return products;
        });

        app.Run();
    }
}

public class Product
{
    public int ProductId { get; set; }
    public string? ProductName { get; set; }

    public string? manufacturer{get; set;}

    public string? category{get; set;}

    public string? expirationDate{get; set;}

    
    public double price{get; set;}
}

public class Customers
{
    public string? userID { get; set; }
    public string? password { get; set; }

    public string? firstName {get; set;}

    public string? lastName {get; set;}

    public string? addressLine1 {get; set;}

    public string? addressLine2 {get; set;}
    public string? city {get; set;}
    public string? zipcode {get; set;}

    public string? state {get; set;}

    public string? emailAddress {get; set;}

    public string? phoneNumber {get; set;}
}