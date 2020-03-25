using Microsoft.AspNetCore.Mvc;

namespace PollCreator.Interfaces.Services
{
	public interface IRequestHeaderHandler
	{
		string GetHeader(ControllerContext context, string headerName);
		string GetCookie(ControllerContext context, string cookieKey);
		string GetUserIp(ControllerContext context);
		string GetHost(ControllerContext context);
	}
}
