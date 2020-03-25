using System.Collections.Generic;
using System.IO;
using WebServerTestAttempt.Interfaces;

namespace WebServerTestAttempt.AdditionalServices
{
	public class MimeTypeResolver : IMimeTypeResolver
	{
		private readonly Dictionary<string, string> _mimeTypesDictionary = new Dictionary<string, string>
		{
			{"css", "text/css"},
			{"gif", "image/gif"},
			{"htm", "text/html"},
			{"html", "text/html"},
			{"jpe", "image/jpeg"},
			{"jpeg", "image/jpeg"},
			{"jpg", "image/jpeg"},
			{"js", "application/x-javascript"},
			{"png", "image/png"},
		};

		public string GetMIMEType(string fileName)
		{
			string extension = Path.GetExtension(fileName).ToLowerInvariant();

			if (extension.Length > 0 &&
			    _mimeTypesDictionary.ContainsKey(extension.Remove(0, 1)))
			{
				return _mimeTypesDictionary[extension.Remove(0, 1)];
			}
			
			return "unknown/unknown";
		}
	}
}
