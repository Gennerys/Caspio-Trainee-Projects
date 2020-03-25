using System.Collections.Generic;

namespace WebServerTestAttempt.RequestHandlers
{
	public class RequestDTO
	{
		public string Method { get; set; }
		public string Version { get; set; }
		public string Path { get; set; }
		public string Host { get; set; }
		public string UserAgent { get; set; }
		public string Cookies { get; set; }
		public bool isAuthenticated { get; set; }
		public Dictionary<string, string> BodyValues  = new Dictionary<string, string>();
		public Dictionary<string, string> ParsedCookie = new Dictionary<string, string>();
	}
}
