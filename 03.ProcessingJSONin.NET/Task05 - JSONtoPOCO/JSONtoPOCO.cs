namespace JSONtoPOCO
{
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;

    public class JSONtoPOCO
    {
        public static void Main(string[] args)
        {
            string json = File.ReadAllText("../../../files/videosJSON.txt");
            JObject jsonObj = JObject.Parse(json);

            var videos = jsonObj["feed"]["entry"].Select(entry => JsonConvert.DeserializeObject<Video>(entry.ToString()));

            GenerateHtml(videos);
        }

        private static void GenerateHtml(IEnumerable<Video> videos)
        {
            var html = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"></head><body>";

            foreach (var video in videos)
            {
                html += string.Format(
                                "<div style=\"float:left; border:1px solid black\">" +
                                "<p style=\"text-align:center\"><a href=\"{0}\">Link</a></p>" +
                                "<iframe src=\"http://www.youtube.com/embed/{1}\" " +
                                "width=\"300\" height=\"225\" " +
                                "frameborder=\"1\" allowfullscreen></iframe>" +
                                "</div>",
                                video.Link.Href, video.Id);
            }

            html += ("</body></html>");
            File.WriteAllText("../../../files/index.html", html);
        }
    }
}
