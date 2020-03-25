using System.Text;
using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.Interfaces
{
	public interface IResponseBuilder
	{
		StringBuilder CreateHeader(ResponseDTO responseDto);
		string CreateCookieHeader(string cookieValue);
	}
}
