using System.Text;
using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.ResponsePageBuilders
{
	public class AuthenticationResponsePageBuilder 
	{
		private readonly string _responseCode;

		public AuthenticationResponsePageBuilder(string responseCode)
		{
			_responseCode = responseCode;
		}

		private string CreatePage()
		{
			var authChallengePage = new StringBuilder();
			authChallengePage.AppendLine("<!DOCTYPE html>");
			authChallengePage.AppendLine("<html>");
			authChallengePage.AppendLine("<head><title> Logged In! </title></head>");
			authChallengePage.AppendLine("<body>");
			authChallengePage.AppendLine("<h2> Logged In! </h2>");
			authChallengePage.AppendLine("</body>");
			authChallengePage.AppendLine("</html>");

			return authChallengePage.ToString();
		}

		public ResponseDTO CreateStaticResponse()
		{
			string bodyContent = CreatePage();

			ResponseDTO responseDto = new ResponseDTO()
			{
				IsStreamResponse = false,
				BodyContent = bodyContent,
				ContentLength = bodyContent.Length,
				Code = _responseCode

			};
			return responseDto;
		}
	}
}
