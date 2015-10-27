/*3. Write a program that retrieves from the Northwind database all product categories and the names of the products in each category.
Can you do this with a single SQL query (with table join)?*/
namespace Task3
{
    using System;
    using System.Data.SqlClient;

    public class Program
    {
        public static void Main()
        {
            SqlConnection dbCon = new SqlConnection("Server=.; Database=Northwind; Integrated Security=true");
            dbCon.Open();
            
            using (dbCon)
            {
                SqlCommand command = new SqlCommand(
                    @"SELECT c.CategoryName, p.ProductName
                    FROM Categories c
                    JOIN Products p
                    ON c.CategoryID = p.CategoryID", 
                    dbCon);
                
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("CATEGORIES");
                int counter = 0;
                while (reader.Read())
                {
                    var categorie = (string)reader["CategoryName"];
                    var product = (string)reader["ProductName"];
                    Console.WriteLine("{0, 2}. Name: {1, -15} product: {1}", ++counter, categorie, product);
                }
            }
        }
    }
}
