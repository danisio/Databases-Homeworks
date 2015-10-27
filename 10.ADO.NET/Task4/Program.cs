/*4. Write a method that adds a new product in the products table in the Northwind database.
Use a parameterized SQL command.*/
namespace Task4
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
                InsertProduct(dbCon);
            }
        }

        private static void InsertProduct(SqlConnection dbCon)
        {
            string newProduct = @"
                INSERT INTO Products 
                    (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
                VALUES
                    (@productName, @supplierId, @categoryId, @quantityPerUnit, @unitPrice, @unitInStock, @unitsOnOrder, @reorderLevel, @discontinued)
            ";

            SqlCommand command = new SqlCommand(newProduct, dbCon);
            command.Parameters.AddWithValue("@productName", "chushki");
            command.Parameters.AddWithValue("@supplierId", 20);
            command.Parameters.AddWithValue("@categoryId", 6);
            command.Parameters.AddWithValue("@quantityPerUnit", "100 g");
            command.Parameters.AddWithValue("@unitPrice", 2.5);
            command.Parameters.AddWithValue("@unitInStock", 20);
            command.Parameters.AddWithValue("@unitsOnOrder", 2);
            command.Parameters.AddWithValue("@reorderLevel", 0);
            command.Parameters.AddWithValue("@discontinued", 0);

            command.ExecuteNonQuery();
            Console.WriteLine("Done!");
        }
    }
}
