/*5. Write a program that retrieves the images for all categories in the Northwind database and stores them as JPG files in the file system.*/
namespace Task5
{
    using System;
    using System.Data.SqlClient;
    using System.IO;

    public class Program
    {
        public static void Main()
        {
            SqlConnection dbCon = new SqlConnection("Server=.; Database=Northwind; Integrated Security=true");
            dbCon.Open();

            using (dbCon)
            {
                SqlCommand pictures = new SqlCommand("SELECT Picture FROM Categories", dbCon);

                SqlDataReader reader = pictures.ExecuteReader();
                using (reader)
                {
                    int count = 1;
                    while (reader.Read())
                    {
                        byte[] image = (byte[])reader["Picture"];
                        string fileName = string.Format(@"..\..\images\{0}.jpg", count++);
                        SaveFile(fileName, image);
                    }
                }

                Console.WriteLine("Done!");
            }
        }

        private static void SaveFile(string fileName, byte[] image)
        {
            FileStream stream = File.OpenWrite(fileName);
            using (stream)
            {
                stream.Write(image, 78, image.Length - 78);
            }
        }
    }
}
