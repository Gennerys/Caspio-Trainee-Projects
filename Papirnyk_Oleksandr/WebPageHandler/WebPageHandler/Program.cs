using System.Text;
using System.Threading.Tasks;


namespace WebPageHandler
{

	class Program
	{		
		static async Task Main(string[] args)
		{
			Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
			Encoding.GetEncoding("windows-1251");
			var applicationController = new ApplicationController();
			await applicationController.RunApplication();
		}
	}
}

