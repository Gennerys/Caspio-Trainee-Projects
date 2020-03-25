using System;
using WebServerTestAttempt.Interfaces;

namespace WebServerTestAttempt.LoggingHandler
{
	public class ConsoleLogger : ILogger
	{
		public void WriteLogMessage(string message)
		{
			Console.WriteLine(message);
		}
	}
}
