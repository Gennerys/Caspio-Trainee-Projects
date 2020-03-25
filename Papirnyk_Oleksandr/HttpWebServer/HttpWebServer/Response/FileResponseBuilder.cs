using System;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.RequestHandlers;
using WebServerTestAttempt.ResponsePageBuilders;
using WebServerTestAttempt.StatusCodeProcessors;

namespace WebServerTestAttempt.Response
{
	public class FileResponseBuilder : IFileResponseBuilder
	{
		private IStatusCodeResponse _statusCodeResponse;
		private IFileService _fileService;

		public FileResponseBuilder(IStatusCodeResponse statusCodeResponse, IFileService fileService)
		{
			_statusCodeResponse = statusCodeResponse;
			_fileService = fileService;
		}
		public ResponseDTO CreateFileResponse(RequestDTO requestDto)
		{
			ResponseDTO responseDto = new ResponseDTO()
			{
				IsStreamResponse = true
			};
			
			string physicalPath = _fileService.GetFilePath(requestDto.Path);

		
			if (_fileService.CheckIfExists(physicalPath))
			{
				if (!requestDto.isAuthenticated)
				{
					ErrorPageBuilder errorPage = new ErrorPageBuilder(
						_statusCodeResponse.GetResponseCode(StatusCode.UNAUTHORIZED));
					responseDto = errorPage.CreateStaticResponse();
				}
				else
				{
					responseDto.IsStreamResponse = true;
					responseDto.FileStream = _fileService.ReadFile(physicalPath);
					responseDto.ContentType = _fileService.GetFileMimeType(requestDto.Path);
					responseDto.ContentLength = Convert.ToInt32(responseDto.FileStream.Length);
					responseDto.Code = _statusCodeResponse.GetResponseCode(StatusCode.OK);
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
