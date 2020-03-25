using System.IO;

namespace WebServerTestAttempt.Response
{
	public class ResponseDTO
	{
		public string HttpVersion { get; set; } = "HTTP/1.1";
		public string Code { get; set; }
		public string Server { get; set; } = "Alex Papirnyk";
		public string ContentType { get; set; }
		public string AcceptRanges { get; set; } = "bytes";
		public int ContentLength { get; set; }
		public FileStream FileStream { get; set; }	
		public string BodyContent { get; set; }
		public string UserName { get; set; }
		public string CookieValue { get; set; }
		public bool IsStreamResponse { get; set; }
	}
}
