using System.Data;
using System.Data.SqlClient;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using System.Text;
using Newtonsoft.Json;

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
    // app.MapGet("/users", async (HttpContext httpContext) =>
    // {
    //   string connectionString = builder.Configuration.GetConnectionString("local_database");

    //   List<Customers> customers = new List<Customers>();

    //   using (SqlConnection connection = new SqlConnection(connectionString))
    //   {
    //     SqlCommand command = new SqlCommand("GetCustomers", connection);
    //     command.CommandType = CommandType.StoredProcedure;

    //     await connection.OpenAsync();

    //     using (SqlDataReader reader = await command.ExecuteReaderAsync())
    //     {
    //       while (await reader.ReadAsync())
    //       {
    //         Customers customer = new Customers();
    //         customer.userID = reader.GetString(reader.GetOrdinal("userID"));
    //         customer.password = reader.GetString(reader.GetOrdinal("password"));
    //         customer.firstName = reader.GetString(reader.GetOrdinal("firstName"));
    //         customer.lastName = reader.GetString(reader.GetOrdinal("lastName"));
    //         customer.addressLine1 = reader.GetString(reader.GetOrdinal("addressLine1"));
    //         customer.addressLine2 = reader.GetString(reader.GetOrdinal("addressLine2"));
    //         customer.city = reader.GetString(reader.GetOrdinal("city"));
    //         customer.zipcode = reader.GetString(reader.GetOrdinal("zipcode"));
    //         customer.state = reader.GetString(reader.GetOrdinal("state"));
    //         customer.emailAddress = reader.GetString(reader.GetOrdinal("emailAddress"));
    //         customer.phoneNumber = reader.GetString(reader.GetOrdinal("phoneNumber"));
    //         customers.Add(customer);
    //       }
    //     }
    //   }

    //   return customers;
    // });
   app.MapPost("/login", async (HttpContext httpContext) =>
{
    string connectionString = builder.Configuration.GetConnectionString("local_database");

    string username = "";
    string password = "";

    using (StreamReader reader = new StreamReader(httpContext.Request.Body, Encoding.UTF8))
    {
        string requestBody = await reader.ReadToEndAsync();
        dynamic data = JsonConvert.DeserializeObject(requestBody);

        // Retrieve the username and password from the request body
        username = data.username;
        password = data.password;
    }

    bool loginSuccessful = false;

    // Perform the login validation using the retrieved username and password
    using (SqlConnection connection = new SqlConnection(connectionString))
    {
        string query = "SELECT COUNT(*) FROM Customers WHERE userID = @UserID AND password = @Password";

        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@UserID", username);
        command.Parameters.AddWithValue("@Password", password);

        await connection.OpenAsync();

        int count = (int)await command.ExecuteScalarAsync();
        loginSuccessful = count > 0;
    }

    // Prepare the login response
    dynamic response = new
    {
        success = loginSuccessful,
        message = loginSuccessful ? "Login successful" : "Invalid username or password"
    };

    // Set the response content type to JSON
    httpContext.Response.ContentType = "application/json";

    // Return the login response as JSON
    string jsonResponse = JsonConvert.SerializeObject(response);
    byte[] responseData = Encoding.UTF8.GetBytes(jsonResponse);
    await httpContext.Response.Body.WriteAsync(responseData);
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