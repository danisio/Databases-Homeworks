namespace JSONtoPOCO
{
    using Newtonsoft.Json;

    public class Video
    {
        [JsonProperty("link")]
        public Link Link { get; set; }

        [JsonProperty("yt:videoId")]
        public string Id { get; set; }
    }
}
