namespace CreateXmlDocument
{
    using System;
    using System.IO;
    using System.Xml.Linq;

    public class CreateXmlDocument
    {
        public static void Main(string[] args)
        {
            string[] data = File.ReadAllText("../../../files/data.txt").Split('\n');

            XElement person = new XElement("person",
                new XElement("name", data[0]),
                new XElement("address", data[1]),
                new XElement("phone", data[2])
                );

            Console.WriteLine("Done");

            person.Save("../../../files/person.xml");
        }
    }
}
