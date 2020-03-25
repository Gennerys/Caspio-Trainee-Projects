using System;
using System.Net.Sockets;
using System.Reflection;
using Ninject;
using WebServerTestAttempt.Controllers;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.RequestHandlers;
using WebServerTestAttempt.Response;

namespace WebServerTestAttempt.AdditionalServices
{
	public class ClientHandler : IDisposable
	{
		private NetworkStream _clientStream;
		public bool isDisposed = false;
		private StandardKernel kernel = new StandardKernel();

		public ClientHandler(TcpClient client)
		{
			_clientStream = client.GetStream();
			kernel.Load(Assembly.GetExecutingAssembly());
		}

		public void Dispose()
		{
			Dispose(true);
			GC.SuppressFinalize(this);
		}

		protected virtual void Dispose(bool disposing)
		{
			if (isDisposed)
				return;

			if (disposing)
			{
				_clientStream.Dispose();
			}

			isDisposed = true;
		}

		public void Process()
		{
			Request request = new Request();
			RequestDTO requestDto = request.Parse(request.ReadRequest(_clientStream));
			RoutingController routingController = new RoutingController(
				new ResponseSender(_clientStream,kernel.Get<IResponseBuilder>()),
				new ResponseHandler(kernel.Get<IStatusCodeResponse>(), kernel.Get<IFileResponseBuilder>(),kernel.Get<IUserController>()));
			routingController.TransferResponse(requestDto);
		}
	}
}
