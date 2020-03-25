using WebServerTestAttempt.StatusCodeProcessors;

namespace WebServerTestAttempt.Interfaces
{
	public interface IStatusCodeResponse
	{
		string GetResponseCode(StatusCode statusCode);
	}
}
