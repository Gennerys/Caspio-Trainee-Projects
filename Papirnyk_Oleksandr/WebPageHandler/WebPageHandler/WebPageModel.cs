using System;


namespace WebPageHandler
{
	public class WebPageModel
	{
		public string Url { get; set; } = String.Empty;
		public int DataLength { get; set; }
		public string Content { get; set; } = String.Empty; 
		public long ElapsedTime { get; set; }
		public DateTime StartDate { get; set; }
		public DateTime EndDate { get; set; }
		public bool IsOperationSuccessful { get; set; } = false;
		public string Error { get; set; } = null;
		
	}
}
