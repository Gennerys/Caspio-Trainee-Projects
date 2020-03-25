using System.Text;
using WebServerTestAttempt.Interfaces;

namespace WebServerTestAttempt.Response
{
	public class ResponseBuilder : IResponseBuilder
	{
		private const string DEFAULT_SERVER_NAME = "Alex Server";
		public StringBuilder CreateHeader(ResponseDTO responseDto)
		{
			StringBuilder header = new StringBuilder();

			responseDto.ContentType = CheckForContentType(responseDto.ContentType);

			header.AppendLine(responseDto.HttpVersion + " " + responseDto.Code);
			header.AppendLine($"Server: {responseDto.Server}");
			header.AppendLine($"Content-Type: {responseDto.ContentType}");
			header.AppendLine($"Accept-Ranges: {responseDto.AcceptRanges}");
			header.AppendLine($"Content-Length: {responseDto.ContentLength}");

			return header;
		}

		public string CreateCookieHeader(string cookieValue)
		{
			return $"Set-Cookie: {DEFAULT_SERVER_NAME}={cookieValue}; path=/;";
		}

		private string CheckForContentType(string contentType)
		{
			if (string.IsNullOrEmpty(contentType))
			{
				contentType = "text/html";
			}

			return contentType;
		}
	}
}
