using System.Collections.Generic;


namespace WebPageHandler
{
	public class DataStorage
	{
		private static List<string> _webPages = new List<string>
		{ 
			"https://msdn.microsoft.com", 
			"https://www.google.com.ua",
			"https://twitter.com",  
			"https://www.codeproject.com",
			"https://learn.javascript.ru",
			"https://www.youtube.com",
			"https://habr.com",
			"http://more-attention.caspio.com"
		};

		public  List<string> GetData()
		{
			List<string> output = _webPages;

			return output;
		}
	}
}
