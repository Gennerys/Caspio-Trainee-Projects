using System.Text;
using WebServerTestAttempt.AdditionalServices;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.LoggingHandler;
using WebServerTestAttempt.RequestHandlers;
using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.Controllers
{
	public class RoutingController
	{
		private IResponseSender _responseSender;
		private IResponseHandler _responseHandler;
		private ILogger _logger;
		
		public RoutingController(IResponseSender responseSender, IResponseHandler responseHandler)
		{
			_responseSender = responseSender;
			_responseHandler = responseHandler;
			_logger = LoggerFactory.GetLogger(LoggerType.Console);
		}

		public void TransferResponse(RequestDTO requestDto)
		{
			requestDto.isAuthenticated = SessionManager.CheckUserAuthentication(requestDto.ParsedCookie);
			ResponseDTO responseDto = _responseHandler.DefineResponseType(requestDto);
			SessionManager.AddUserSession(responseDto.UserName, responseDto.CookieValue);

			_responseSender.Send(responseDto);

			StringBuilder logMessage = new StringBuilder();
			logMessage.Append(requestDto.Method);
			logMessage.Append(" ");
			logMessage.Append(requestDto.Version);
			logMessage.Append(" ");
			logMessage.Append(requestDto.Path);
			logMessage.AppendLine();
			logMessage.AppendLine($"Host: {requestDto.Host}");
			logMessage.AppendLine($"User-Agent: {requestDto.UserAgent}");
			logMessage.AppendLine($"Response: {responseDto.Code}");

			_logger.WriteLogMessage(logMessage.ToString());

		}

	}
}
