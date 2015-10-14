namespace TraverseDirectory
{
    using System.IO;
    using System.Linq;
    using System.Text;
    using System.Xml;

    public class TraverseDirectory
    {
        private const string DirectoryToTraverse = "../../../../02.ProcessingXMLin.NET";

        public static void Main(string[] args)
        {
            var xmlTextWriter = new XmlTextWriter("../../../files/directory.xml", Encoding.UTF8);
            var startupDirectory = new DirectoryInfo(DirectoryToTraverse);

            using (xmlTextWriter)
            {
                xmlTextWriter.Formatting = Formatting.Indented;
                xmlTextWriter.IndentChar = '\t';
                xmlTextWriter.Indentation = 1;

                xmlTextWriter.WriteStartDocument();
                
                xmlTextWriter.WriteStartElement("directories");
                Traverse(xmlTextWriter, startupDirectory);
                
                xmlTextWriter.WriteEndDocument();
            }
        }

        private static void Traverse(XmlTextWriter writer, DirectoryInfo dirInfo)
        {
            if (!dirInfo.GetFiles().Any() && !dirInfo.GetDirectories().Any())
            {
                return;
            }

            writer.WriteStartElement("dir");
            writer.WriteAttributeString("name", dirInfo.Name);

            foreach (var file in dirInfo.GetFiles())
            {
                writer.WriteStartElement("file");
                writer.WriteAttributeString("name", file.Name);
                writer.WriteEndElement();
            }

            foreach (var dir in dirInfo.GetDirectories())
            {
                Traverse(writer, dir);
            }

            writer.WriteEndElement();
        }
    }
}

