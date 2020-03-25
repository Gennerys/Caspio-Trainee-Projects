using System.Collections.Generic;
using System.Threading.Tasks;


namespace WebPageHandler
{
	class ApplicationController
	{
		public async Task RunApplication()
		{
			var webPageReader = new WebPageReader();
			var outputPrinter = new OutputPrinter();
			var dataStorage = new DataStorage();

			List<Task<WebPageModel>> _tasks = new List<Task<WebPageModel>>();

			foreach (string webPage in dataStorage.GetData())
			{
				_tasks.Add(webPageReader.DownloadWebPageAsync(webPage));				
			}

			while (_tasks.Count> 0)
			{
				Task<WebPageModel> t = await Task.WhenAny(_tasks);
				_tasks.Remove(t);
				outputPrinter.ReportWebPageInfoStringBuilder(await t);
			}
			webPageReader.Dispose();
		}
	}
}
