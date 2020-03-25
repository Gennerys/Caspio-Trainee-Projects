using System;
using System.Text;


namespace WebPageHandler
{
	public class OutputPrinter
	{		
		public void ReportWebPageInfo(WebPageModel data)
		{
			string content = data.Content;

			WrapperUI wrapperUI = new WrapperUI();

			try 
			{
				if(content.Length < 30)
				{
					content = data.Content?.Trim().Replace(Environment.NewLine, string.Empty).Substring(0, content.Length);
				}
				else
				{
					content = data.Content?.Trim().Replace(Environment.NewLine, string.Empty).Substring(0, 30);
				}
			} 
			catch(ArgumentOutOfRangeException e)
			{
				data.IsOperationSuccessful = false;
				data.Error = e.Message;
			}
			wrapperUI.ShowMessage("---------------------------------------------------------");
			wrapperUI.ShowMessage($"\r\n { data.Url}");
			wrapperUI.ShowMessage($"\r\n Data Length = {data.DataLength}");
			wrapperUI.ShowMessage($"\r\n Elapsed Time = {data.ElapsedTime}");
			wrapperUI.ShowMessage($"\r\n Task started and completed: {data.StartDate.ToString("HH:mm:ss.fff")} -- {data.EndDate.ToString("HH:mm:ss.fff")}");

			if (data.IsOperationSuccessful == true)
			{
				wrapperUI.ShowMessage($"\r\n First 30 elements of content:\n {content}");
			}
			else
			{
				wrapperUI.ShowMessage($"\r\n Error Message = {data.Error}");
			}
			wrapperUI.ShowMessage("---------------------------------------------------------");
		}

		public void ReportWebPageInfoStringBuilder(WebPageModel data)
		{
			string content = data.Content;

			WrapperUI wrapperUI = new WrapperUI();

			try
			{
				if (content.Length < 30)
				{
					content = data.Content?.Trim().Replace(Environment.NewLine, string.Empty).Substring(0, content.Length);
				}
				else
				{
					content = data.Content?.Trim().Replace(Environment.NewLine, string.Empty).Substring(0, 30);
				}
			}
			catch (ArgumentOutOfRangeException e)
			{
				data.IsOperationSuccessful = false;
				data.Error = e.Message;
			}

			StringBuilder output = new StringBuilder();
			output.AppendLine("---------------------------------------------------------");
			output.AppendLine($" {data.Url}");
			output.AppendLine($" Data Length = {data.DataLength}");
			output.AppendLine($" Elapsed Time = {data.ElapsedTime}");
			output.AppendLine($" Task started and completed: {data.StartDate.ToString("HH:mm:ss.fff")}  -- {data.EndDate.ToString("HH:mm:ss.fff")}");

			if (data.IsOperationSuccessful == true)
			{
				output.AppendLine($" First 30 elements of content:\n{content}");
			}
			else
			{
				output.AppendLine($" Error Message = {data.Error}");
			}

			output.AppendLine("\n---------------------------------------------------------");
			wrapperUI.ShowMessage(output.ToString());
		}
	}
}
