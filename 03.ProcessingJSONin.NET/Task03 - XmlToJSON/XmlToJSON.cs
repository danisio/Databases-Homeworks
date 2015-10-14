namespace XmlToJSON
{
    using System;
    using System.IO;
    using System.Xml.Linq;
    using Newtonsoft.Json;

    public class XmlToJSON
    {
        public static void Main(string[] args)
        {
            var path = "../../../files/videos.xml";
            var doc = XDocument.Load(path);

            string json = JsonConvert.SerializeXNode(doc, Formatting.Indented);
            
            File.WriteAllText("../../../files/videosJSON.txt", json);

            Console.WriteLine("The file was parsed!");
        }
    }
}
