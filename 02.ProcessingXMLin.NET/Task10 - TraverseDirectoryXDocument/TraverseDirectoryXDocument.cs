namespace TraverseDirectoryXDocument
{
    using System.IO;
    using System.Xml.Linq;

    public class TraverseDirectoryXDocument
    {
        private const string DirectoryToTraverse = "../../../../02.ProcessingXMLin.NET";
        
        public static void Main(string[] args)
        {
            var startupDirectory = new DirectoryInfo(DirectoryToTraverse);
            var xmlDirectoryTree = BuildXmlDirectoryTree(startupDirectory);
            var xDocument = new XDocument(xmlDirectoryTree);
            xDocument.Save("../../../files/directoryXDocument.xml");
            System.Console.WriteLine("Done");
        }

        private static XElement BuildXmlDirectoryTree(DirectoryInfo dirInfo)
        {
            var root = new XElement("directories");
            var subtreeXml = Traverse(dirInfo);
            root.Add(subtreeXml);
            return root;
        }

        private static XElement Traverse(DirectoryInfo dirInfo)
        {
            var dirXml = new XElement("dir", new XAttribute("name", dirInfo.Name));

            foreach (var file in dirInfo.GetFiles())
            {
                var fileXml = new XElement("file", new XAttribute("name", file.Name));
                dirXml.Add(fileXml);
            }

            foreach (var dir in dirInfo.GetDirectories())
            {
                dirXml.Add(Traverse(dir));
            }

            return dirXml;
        }
    }
}
