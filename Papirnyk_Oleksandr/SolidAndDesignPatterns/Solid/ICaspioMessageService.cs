// Task:
// #1. Refactor this code to avoid SOLID principles violation.

namespace CaspioMessageService
{
	class Program
	{
		static void Main(string[] args)
		{
			var messageController = new MessageController(new EmailMessage());
			messageController.SendMessage();
			messageController = new MessageController(new SMSMessage());
			messageController.SendMessage();
			Console.ReadKey();
		}
	}

	public class MessageController
	{
		private IMessage _sender;
		public MessageController(IMessage sender)
		{
			_sender = sender;
		}
		public void SendMessage()
		{
			_sender.Send();
		}
	}

	public interface IEmailMessage
	{
		IList<string> CCToAddress { get; set; }
		string Subject { get; set; }
	}

	public interface IMessage
	{
		IList<string> To { get; set; }
		string MessageText { get; set; }
		void Send();
	}

	public class EmailMessage : IMessage, IEmailMessage
	{
		public IList<string> To { get; set; }
		public string MessageText { get; set; }
		public IList<string> CCToAddress { get; set; }
		public string Subject { get; set; }

		public void Send()
		{
			MessageText = "Message from EmailMessage";
			Console.WriteLine(MessageText);
		}
	}

	public class SMSMessage : IMessage
	{
		public IList<string> To { get; set; }
		public string MessageText { get; set; }

		public void Send()
		{
			MessageText = "Message from SMSMessage";
			Console.WriteLine(MessageText);
		}
	}
}