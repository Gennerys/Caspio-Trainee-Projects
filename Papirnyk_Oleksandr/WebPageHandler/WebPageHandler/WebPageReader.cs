using System;
using System.Diagnostics;
using System.Net.Http;
using System.Threading.Tasks;


namespace WebPageHandler
{
	class WebPageReader : IDisposable
	{
		public static readonly HttpClient _client = new HttpClient();
		public bool isDisposed = false;
		public async Task<WebPageModel> DownloadWebPageAsync(string webPageUrl)
		{
			WebPageModel webPageModel = new WebPageModel();

			Stopwatch stopwatch = new Stopwatch();
			stopwatch.Start();

			webPageModel.StartDate = DateTime.UtcNow;
			webPageModel.Url = webPageUrl;

			try
			{
				HttpResponseMessage response = await _client.GetAsync(webPageUrl);
				string content = await response.Content.ReadAsStringAsync();
				webPageModel.DataLength = content.Length;
				webPageModel.Content = content;
				webPageModel.IsOperationSuccessful = true;
			}
			catch (HttpRequestException e)
			{
				webPageModel.IsOperationSuccessful = false;
				webPageModel.Error = e.Message;
			}

			stopwatch.Stop();
			webPageModel.ElapsedTime = stopwatch.ElapsedMilliseconds;
			webPageModel.EndDate = webPageModel.StartDate.AddMilliseconds(webPageModel.ElapsedTime);

			return webPageModel;
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
				_client.Dispose();
				// Free any other managed objects here.
				//
			}

			isDisposed = true;
		}
	}
}
