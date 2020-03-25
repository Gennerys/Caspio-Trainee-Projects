using System;
using System.Linq;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.RequestHandlers;
using WebServerTestAttempt.ResponsePageBuilders;
using WebServerTestAttempt.StatusCodeProcessors;

namespace WebServerTestAttempt.Response
{
	public class ResponseHandler : IResponseHandler
	{
		private IStatusCodeResponse _statusCodeResponse;
		private IFileResponseBuilder _fileResponseBuilder;
		private IUserController _userController;

		public ResponseHandler(IStatusCodeResponse statusCodeResponse, IFileResponseBuilder fileResponseBuilder, IUserController userController)
		{
			_statusCodeResponse = statusCodeResponse;
			_fileResponseBuilder = fileResponseBuilder;
			_userController = userController;
		}

		private bool CheckRequestPath(string path)
		{
			bool isCorrectRequestForFileResource =  (path.StartsWith("\\pages") || path.StartsWith("\\images"));

			return isCorrectRequestForFileResource;
		}

		public ResponseDTO DefineResponseType(RequestDTO requestDto)
		{
			ResponseDTO responseDto = new ResponseDTO();

			if (CheckRequestPath(requestDto.Path))
			{
				responseDto = _fileResponseBuilder.CreateFileResponse(requestDto);
			}
			else if (requestDto.Path == "\\auth")
			{
				AuthenticationPageBuilder authenticationPage = new AuthenticationPageBuilder(
					_statusCodeResponse.GetResponseCode(StatusCode.OK));
				responseDto = authenticationPage.CreateStaticResponse();
			}
			else if (requestDto.Path == "\\auth\\challenge")
			{
				bool isValidUser = _userController.IsValidUser(requestDto.BodyValues);
				if (!isValidUser)
				{
					ErrorPageBuilder errorPage = new ErrorPageBuilder(
						_statusCodeResponse.GetResponseCode(StatusCode.UNAUTHORIZED));
					responseDto = errorPage.CreateStaticResponse();
				}
				else
				{
					AuthenticationResponsePageBuilder authenticationResponsePage =
						new AuthenticationResponsePageBuilder(
							_statusCodeResponse.GetResponseCode(StatusCode.OK));
					responseDto = authenticationResponsePage.CreateStaticResponse();
					responseDto.UserName = requestDto.BodyValues.FirstOrDefault(x => x.Key == "user").Value;
					responseDto.CookieValue = Guid.NewGuid().ToString();
				}
			}
			else
			{
				ErrorPageBuilder errorPage = new ErrorPageBuilder(
					_statusCodeResponse.GetResponseCode(StatusCode.NOT_FOUND));
				responseDto = errorPage.CreateStaticResponse();
			}

			return responseDto;
		}

	}
}
