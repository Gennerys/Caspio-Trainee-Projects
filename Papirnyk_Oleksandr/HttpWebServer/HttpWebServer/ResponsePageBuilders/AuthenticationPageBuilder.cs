using System.Text;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.ResponsePageBuilders
{
	public class AuthenticationPageBuilder
	{
		private readonly string _responseCode;

		public AuthenticationPageBuilder(string responseCode)
		{
			_responseCode = responseCode;
		}

		private string CreatePage()
		{
			var loginForm = new StringBuilder();
			loginForm.AppendLine("<!DOCTYPE html>");
			loginForm.AppendLine("<html>");
			loginForm.AppendLine("<head><title> Login </title></head>");
			loginForm.AppendLine("<body>");
			loginForm.AppendLine("<h2> LOGIN </h2>");
			loginForm.AppendLine("<form method = \"post\" action = \"/auth/challenge\">");
			loginForm.AppendLine("Username: <input type = \"text\" name = \"user\" size = \"25\"/><br/>");
			loginForm.AppendLine("Password: <input type =\"password\" name = \"pw\" size = \"10\"/><br/><br/>");
			loginForm.AppendLine("<input type = \"hidden\" name = \"action\" value = \"challenge\">");
			loginForm.AppendLine("<input type = \"submit\" value = \"SEND\"/>");
			loginForm.AppendLine("</form>");
			loginForm.AppendLine("</body>");
			loginForm.AppendLine("</html>");

			return loginForm.ToString();
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
