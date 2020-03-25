using System.Collections.Generic;

namespace WebServerTestAttempt.Interfaces
{
	public interface IFormValidator
	{
		bool CheckFormInput(Dictionary<string, string> bodyValues);
	}
}
