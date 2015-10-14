namespace Task05XmlReader
{
    using System;
    using System.Xml;
    
    public class Task05XmlReader
    {
        static void Main(string[] args)
        {
            Console.WriteLine("List of all songs in the catalog:");

            int count = 0;

            using (XmlReader reader = XmlReader.Create("../../../files/catalog.xml"))
            {
                while (reader.Read())
                {
                    if ((reader.NodeType == XmlNodeType.Element) &&
                        (reader.Name == "title"))
                    {
                        count++;
                        Console.WriteLine("{0,3}. {1}", count, reader.ReadElementString());
                    }
                }
            }
        }
    }
}
