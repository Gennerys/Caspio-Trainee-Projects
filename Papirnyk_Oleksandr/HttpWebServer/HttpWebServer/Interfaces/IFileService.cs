using System.IO;

namespace WebServerTestAttempt.Interfaces
{
	public interface IFileService
	{
		bool CheckIfExists(string filePath);
		string GetFileMimeType(string fileName);
		string GetFilePath(string fileName);
		FileStream ReadFile(string filePath);
	}
}
