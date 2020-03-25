using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.Interfaces
{
	public interface IResponseSender
	{
		void Send(ResponseDTO responseDto);
	}
}
