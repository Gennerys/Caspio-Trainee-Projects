namespace WebServerTestAttempt
{
	class Program
	{
		static void Main(string[] args)
		{
			var server = new Server();
			server.RunServer(1234);
		}
	}
}
