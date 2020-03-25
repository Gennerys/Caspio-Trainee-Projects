using WebServerTestAttempt.RequestHandlers;
using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.Interfaces
{
	public interface IFileResponseBuilder
	{
		ResponseDTO CreateFileResponse(RequestDTO requestDto);
	}
}
