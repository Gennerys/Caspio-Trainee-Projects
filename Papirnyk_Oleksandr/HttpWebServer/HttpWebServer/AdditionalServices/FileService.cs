using System.IO;
using WebServerTestAttempt.Interfaces;

namespace WebServerTestAttempt.AdditionalServices
{
	public class FileService : IFileService
	{
		private readonly IMimeTypeResolver _mimeType;

		public FileService(IMimeTypeResolver mimeType)
		{
			_mimeType = mimeType;
		}

		public FileStream ReadFile(string filePath)
		{
			FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read);
			return fileStream;
		}

		public string GetFilePath(string fileName)
		{
			var baseDirectory = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);

			if (GetFileMimeType(fileName) == "text/html")
			{
				baseDirectory = $"{baseDirectory}{fileName}";
			}
			else if (GetFileMimeType(fileName) == "image/jpeg")
			{
				baseDirectory = $"{baseDirectory}{fileName}";
			}
			else
			{
				baseDirectory = $"{baseDirectory}index.html"; 
			}

			return baseDirectory;
		}

		public bool CheckIfExists(string filePath)
		{
			if (File.Exists(filePath))
			{
				return true;
			}

			return false;
		}

		public string GetFileMimeType(string fileName)
		{
			return _mimeType.GetMIMEType(fileName);
		}
	}
}
