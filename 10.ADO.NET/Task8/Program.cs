/*8. Write a program that reads a string from the console and finds all products that contain this string.
Ensure you handle correctly characters like ', %, ", \ and _.
 */
namespace Task8
{
    using System;
    using System.Data.SqlClient;

    public class Program
    {
        public static void Main()
        {
            Console.Write("Enter pattern: ");
            string pattern = Console.ReadLine();

            Console.WriteLine();
            Console.WriteLine("Products:");
            SearchProductsForPattern(pattern);
        }

        private static void SearchProductsForPattern(string pattern)
        {
            SqlConnection dbCon = new SqlConnection("Server=.; Database=Northwind; Integrated Security=true");
            dbCon.Open();

            using (dbCon)
            {
                string commandString = @"
                    SELECT ProductName
                    FROM Products
                    WHERE CHARINDEX(@pattern, ProductName) > 0
                ";

                SqlCommand command = new SqlCommand(commandString, dbCon);
                command.Parameters.AddWithValue("@pattern", pattern);

                int counter = 1;
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var productName = reader["ProductName"];
                        Console.WriteLine("{0,2}. {1}", counter++, productName);
                    }
                }
            }
        }
    }
}
