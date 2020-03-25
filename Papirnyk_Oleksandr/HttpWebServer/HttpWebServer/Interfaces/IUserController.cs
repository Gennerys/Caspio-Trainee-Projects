using System.Collections.Generic;

namespace WebServerTestAttempt.Interfaces
{
	public interface IUserController
	{
		bool IsValidUser(Dictionary<string, string> bodyValues);
	}
}
