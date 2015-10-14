namespace XmlReaderXmlWriter
{
    using System;
    using System.Text;
    using System.Xml;

    public class XmlReaderXmlWriter
    {
        public static void Main(string[] args)
        {
            string fileName = "../../../files/albums.xml";
            Encoding encoding = Encoding.UTF8;
            
            using (XmlTextWriter writer = new XmlTextWriter(fileName, encoding))
            {
                writer.Formatting = Formatting.Indented;
                writer.IndentChar = '\t';
                writer.Indentation = 1;

                writer.WriteStartDocument();
                writer.WriteStartElement("albums");

                using (XmlReader reader = XmlReader.Create("../../../files/catalog.xml"))
                {
                    while (reader.Read())
                    {
                        if (reader.NodeType == XmlNodeType.Element)
                        {
                            if (reader.Name == "name")
                            {
                                writer.WriteStartElement("album");
                                writer.WriteElementString("title", reader.ReadElementString());
                            }

                            if (reader.Name == "artist")
                            {
                                writer.WriteElementString("author", reader.ReadElementString());
                                writer.WriteEndElement();
                            }
                        }
                    }

                    writer.WriteEndDocument();
                }
            }

            Console.WriteLine("Done");
        }
    }
}
