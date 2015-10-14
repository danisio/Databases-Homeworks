namespace DownloadFeed
{
    using System;
    using System.Net;

    public class DownloadFeed
    {
        public static void Main(string[] args)
        {
            string myStringWebResource = "https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw";
            string fileName = "../../../files/videos.xml";

            WebClient myWebClient = new WebClient();

            myWebClient.DownloadFile(myStringWebResource, fileName);
            Console.WriteLine("Download was successful");
        }
    }
}
