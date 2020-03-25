using WebServerTestAttempt.RequestHandlers;
using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.Interfaces
{
	public interface IResponseHandler
	{
		ResponseDTO DefineResponseType(RequestDTO requestDto);
	}
}
