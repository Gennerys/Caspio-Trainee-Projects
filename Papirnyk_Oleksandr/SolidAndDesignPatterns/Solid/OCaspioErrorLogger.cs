// Task:
// #2. Refactor this code to avoid SOLID principles violation.
// #1. Add new feature - logging to Database.

public class Program
{
	public void Main(string [] args)
	{
		var caspioLogger = new CaspioLogger(new TextFileLogger());
		caspioLogger.LogError("Some error in txt file");
		caspioLogger = new CaspioLogger(new EventLogger());
		caspioLogger.LogError("Some error in event");
		caspioLogger = new CaspioLogger(new DatabaseLogger());
		caspioLogger.LogError("Error in database");		
	}
}

public class CaspioLogger
{
	private ILogger _errorLog;

	public CaspioErrorLogger(IErrorLog errorLog)
	{
		_errorLog = errorLog;
	}

	public void LogError(string message)
	{
		_errorLog.WriteLogMessage(message);
	}
}

interface ILogger
{
	void WriteLogMessage(string message);	
}

public class TextFileLogger : ILogger
{
	public void WriteLogMessage(string message)
	{
		System.IO.File.WriteAllText(@"C:\logs\Errors.txt", message);
	}
}
public class EventLogger : ILogger
{
	public void WriteLogMessage(string message)
	{
		string source = "Caspio.App";
		string log = "App";

		if (!EventLog.SourceExists(source))
		{
			EventLog.CreateEventSource(source, log);
		}
		EventLog.WriteEntry(source, message, EventLogEntryType.Error, 1);
	}
}

public class DatabaseLogger : ILogger
{
	public void WriteLogMessage(string message)
	{
		System.Console.WriteLine("Insert to database:{0}",message);
	}
}