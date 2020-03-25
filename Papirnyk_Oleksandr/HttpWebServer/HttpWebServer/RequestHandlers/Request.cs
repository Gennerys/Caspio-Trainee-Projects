using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.LoggingHandler;

namespace WebServerTestAttempt.RequestHandlers
{
	public class Request
	{
		private ILogger _logger;

		public Request()
		{
			_logger = LoggerFactory.GetLogger(LoggerType.Console);
		}
		public string ReadRequest(NetworkStream network)
		{
			StringBuilder requestMessage = new StringBuilder();
			if (network.CanRead)
			{
				byte[] myReadBuffer = new byte[1024];
				int numberOfBytesRead = 0;

				do
				{
					numberOfBytesRead = network.Read(myReadBuffer, 0, myReadBuffer.Length);

					requestMessage.AppendFormat("{0}", Encoding.ASCII.GetString(myReadBuffer, 0, numberOfBytesRead));

				}
				while (network.DataAvailable);

			}
			else
			{
				_logger.WriteLogMessage("NetworkStream unreachable");
				throw new SocketException();
			}

			return requestMessage.ToString();

		}
		public RequestDTO Parse(string requestMessage)
		{
			if (string.IsNullOrWhiteSpace(requestMessage))
			{
				throw new ArgumentException();
			}

			RequestDTO requestDto = new RequestDTO();

			if (string.IsNullOrWhiteSpace(requestMessage))
			{
				throw new ArgumentException();
			}
			else
			{
				Dictionary<string, string> headers = new Dictionary<string, string>();

				string[] headersParts = requestMessage.Split(new string[] { Environment.NewLine }, StringSplitOptions.None);

				foreach (var line in headersParts)
				{
					if (line.Contains(": "))
					{
						string[] headerKeyValue = line.Split(new string[] { ": " }, StringSplitOptions.None);
						if (headerKeyValue.Length != 2)
						{
							_logger.WriteLogMessage("Wrong headers format");
							throw new ArgumentException();
						}
						else
						{
							headers.Add(headerKeyValue[0], headerKeyValue[1]);
						}
					}
				}

				string[] requestLine = headersParts[0].Split(' ');
				requestDto.Method = requestLine[0];
				requestDto.Path = requestLine[1].Replace('/', '\\');
				requestDto.Version = requestLine[2];
				requestDto.Host = headers.FirstOrDefault(x => x.Key == "Host").Value;
				requestDto.UserAgent = headers.FirstOrDefault(x => x.Key == "User-Agent").Value;
				requestDto.Cookies = headers.FirstOrDefault(x => x.Key == "Cookie").Value;
				requestDto.ParsedCookie = ParseCookie(requestDto.Cookies);
				requestDto.BodyValues = ParseBody(headersParts[headersParts.Length - 1]);
			}

			return requestDto;
		}
		private Dictionary<string, string> ParseCookie(string cookieHeader)
		{
			Dictionary<string, string> cookies = new Dictionary<string, string>();

			if (!string.IsNullOrEmpty(cookieHeader))
			{
				string[] cookieParts = cookieHeader.Trim().Split(';');
				foreach (var line in cookieParts)
				{
					if (!line.Contains("="))
					{
						continue;
					}
					string[] cookieNameValue = line.Split('=');
					cookies.Add(cookieNameValue[0], cookieNameValue[1]);
				}
			}

			return cookies;
		}

		private Dictionary<string, string> ParseBody(string requestBodyData)
		{
			Dictionary<string,string> bodyValues = new Dictionary<string, string>();
			if (!string.IsNullOrEmpty(requestBodyData))
			{
				string[] bodyParts = requestBodyData.Split('&');

				foreach (var line in bodyParts)
				{
					string[] bodyKeyValuePair = line.Split('=');
					bodyValues.Add(bodyKeyValuePair[0],bodyKeyValuePair[1]);
				}
			}

			return bodyValues;
		}
	}
}
