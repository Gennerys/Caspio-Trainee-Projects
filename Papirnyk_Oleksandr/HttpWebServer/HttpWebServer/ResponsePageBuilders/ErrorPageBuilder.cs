using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.ResponsePageBuilders
{
	public class ErrorPageBuilder 
	{
		private readonly string _responseCode;

		public ErrorPageBuilder(string responseCode)
		{
			_responseCode = responseCode;
		}
		private string CreatePage()
		{
			return $"<html><body><h1>{_responseCode}</h1></body></html>";
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
