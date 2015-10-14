namespace SelectVideos
{
    using System;
    using System.IO;
    using System.Linq;
    using Newtonsoft.Json.Linq;

    public class SelectVideos
    {
        public static void Main(string[] args)
        {
            string json = File.ReadAllText("../../../files/videosJSON.txt");
            JObject jsonObj = JObject.Parse(json);

            var titles = jsonObj["feed"]["entry"].Select(entry => entry["title"]);

            var index = 1;
            
            Console.WriteLine("List of all videos:");
            foreach (var title in titles)
            {
                Console.WriteLine("{0}. {1}", index++, title);
            }
        }
    }
}
