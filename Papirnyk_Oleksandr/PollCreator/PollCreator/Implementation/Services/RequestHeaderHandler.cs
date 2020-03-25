using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PollCreator.Interfaces.Services;

namespace PollCreator.Implementation.Services
{
	public class RequestHeaderHandler : IRequestHeaderHandler
	{
		public string GetCookie(ControllerContext context, string cookieKey)
		{
			string value = string.Empty;
			if (context.HttpContext.Request.Cookies.ContainsKey(cookieKey))
			{
				value = context.HttpContext.Request.Cookies[cookieKey];
			}

			return value;
		}

		public string GetHeader(ControllerContext context, string headerName)
		{
			string value = string.Empty;

			if (context.HttpContext.Request.Headers.ContainsKey(headerName))
			{
				value = context.HttpContext.Request.Headers[headerName].ToString();
			}
			return value;
		}

		public string GetUserIp(ControllerContext context)
		{
			var clientIp = context.HttpContext.Connection.RemoteIpAddress.ToString();

			return clientIp;
		}
		public string GetHost(ControllerContext context)
		{
			string myHostUrl = string.Empty;
			if (context.HttpContext.Request.Host.HasValue)
			{
				myHostUrl = $"{context.HttpContext.Request.Scheme}://{context.HttpContext.Request.Host}";
			}

			return myHostUrl;
		}
	}
}
