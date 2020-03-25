// Task:
// #1. Refactor this code to avoid SOLID principles violation.

class Program
{
    static void Main(string[] args)
    {
        var processor = new SomeProcessor(new TextLogger());
        processor.Process("Some message");
    }
}
 
public class SomeProcessor
{
    private ILogger _logger;

    public SomeProcessor(ILogger logger)
    {
        _logger = logger;
    }

    public void Process(string message)
    {
        // do something       
        _logger.WriteLogMessage(message);
    }
}
 
public class TextLogger : ILogger
{
    public void WriteLogMessage(string message)
    { 
        Console.WriteLine(message);
	}
}

public interface ILogger
{
    void WriteLogMessage(string message);
}
