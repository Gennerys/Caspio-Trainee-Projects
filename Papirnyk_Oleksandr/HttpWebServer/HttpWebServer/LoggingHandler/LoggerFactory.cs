using WebServerTestAttempt.Interfaces;

namespace WebServerTestAttempt.LoggingHandler
{
	public class LoggerFactory
	{
		public static ILogger GetLogger(LoggerType type)
		{
			switch (type)
			{
				case LoggerType.Console:
					return new ConsoleLogger();
				default:
					return new ConsoleLogger();
			}
		}
	}
}
