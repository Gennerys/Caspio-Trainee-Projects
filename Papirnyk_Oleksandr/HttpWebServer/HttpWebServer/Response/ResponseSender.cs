using System;
using System.IO;
using System.Net.Sockets;
using System.Text;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.LoggingHandler;

namespace WebServerTestAttempt.Response
{
	public class ResponseSender : IResponseSender
	{
		private NetworkStream _clientStream;
		private ILogger _logger;
		private IResponseBuilder _responseBuilder;

		public ResponseSender(NetworkStream clientStream, IResponseBuilder responseBuilder)
		{
			_clientStream = clientStream;
			_logger = LoggerFactory.GetLogger(LoggerType.Console);
			_responseBuilder = responseBuilder;
		}
		private void SendToBrowser(byte[] sendData, NetworkStream network)
		{
			try
			{
				network.Write(sendData, 0, sendData.Length);
			}
			catch (Exception e)
			{
				_logger.WriteLogMessage($"Error Occurred : {e} ");
			}
		}

		public void Send(ResponseDTO responseDto)
		{
			if (responseDto.IsStreamResponse)
			{
				SendFileResponse(responseDto);
			}
			else
			{
				SendStaticResponse(responseDto);
			}
		}

		private void SendStaticResponse(ResponseDTO responseDto)
		{
			StringBuilder headers = _responseBuilder.CreateHeader(responseDto);
			if (!string.IsNullOrEmpty(responseDto.CookieValue))
			{
				headers.AppendLine(_responseBuilder.CreateCookieHeader(responseDto.CookieValue));
			}
			headers.AppendLine();
			headers.AppendLine(responseDto.BodyContent);

			SendToBrowser(Encoding.ASCII.GetBytes(headers.ToString()),_clientStream);
		}

		public void SendFileResponse(ResponseDTO responseDto)
		{
			var reader = new BinaryReader(responseDto.FileStream, Encoding.ASCII);
			int chunkSize = 1024;
			var buffer = new byte[chunkSize];
			int readedBytes;
			StringBuilder responseHeader = _responseBuilder.CreateHeader(responseDto);
			responseHeader.AppendLine();

			SendToBrowser(Encoding.ASCII.GetBytes(responseHeader.ToString()), _clientStream);

			while ((readedBytes = reader.Read(buffer, 0, buffer.Length)) != 0)
			{
				_clientStream.Write(buffer, 0, readedBytes);
			}
			reader.Close();
			responseDto.FileStream.Close();

		}


	}
}
