////2. Write a program that retrieves the name and description of all categories in the Northwind DB.
namespace Task2
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
                SqlCommand command = new SqlCommand("SELECT CategoryName, Description FROM Categories", dbCon);
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("CATEGORIES");
                int counter = 0;
                while (reader.Read())
                {
                    var categorie = (string)reader["CategoryName"];
                    var description = (string)reader["Description"];
                    Console.WriteLine("{0}. Name: {1, -15} Description: {1}", ++counter, categorie, description);
                }
            }
        }
    }
}
