using System;
using System.Net;
using System.Net.Sockets;
using System.Threading.Tasks;
using WebServerTestAttempt.AdditionalServices;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.LoggingHandler;

namespace WebServerTestAttempt
{
	public class Server : IDisposable
	{
		private TcpListener _server;
		private readonly ILogger _logger;
		private bool _isRunning;
		private bool _isDisposed;
		private TcpClient client;

		public Server()
		{
			_logger = LoggerFactory.GetLogger(LoggerType.Console);
		}

		public void RunServer(int port)
		{
			_server = new TcpListener(IPAddress.Any, port);
			_server.Start();
			_logger.WriteLogMessage("Server is running...");
			_isRunning = true;
			while (_isRunning)
			{
				client =  _server.AcceptTcpClient();
				_logger.WriteLogMessage($"Client connected{Environment.NewLine}ID :{client.Client.RemoteEndPoint}{Environment.NewLine}Date:{DateTime.Now}");
				Task.Run((() => ProcessClient(client)));
			}
		}

		public void ProcessClient(TcpClient client)
		{
			try
			{
				using (ClientHandler clientHandler = new ClientHandler(client))
				{
					clientHandler.Process();
				}
			}
			catch (Exception exception)
			{
				_logger.WriteLogMessage(exception.Message);
			}

		}
		public void Dispose()
		{
			Dispose(true);
			GC.SuppressFinalize(this);
		}

		protected virtual void Dispose(bool disposing)
		{
			if (_isDisposed)
				return;

			if (disposing)
			{
				client.Dispose();
			}

			_isDisposed = true;
		}


	}
}
