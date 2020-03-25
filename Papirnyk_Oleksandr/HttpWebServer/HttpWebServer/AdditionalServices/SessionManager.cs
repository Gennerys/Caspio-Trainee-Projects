using System.Collections.Generic;
using System.Collections.Specialized;

namespace WebServerTestAttempt.AdditionalServices
{
	public static class SessionManager 
	{
		private static NameValueCollection _authenticatedUsers = new NameValueCollection();

		public static void AddUserSession(string username, string cookieValue)
		{
			_authenticatedUsers.Add(username,cookieValue);
		}

		public static bool CheckUserAuthentication(Dictionary<string,string> parsedCookies)
		{
			bool isAuthenticated = false;
			foreach (string key in _authenticatedUsers.AllKeys)
			{
				if (parsedCookies.ContainsValue(_authenticatedUsers[key]))
				{
					isAuthenticated = true;
					break;
				}
			}

			return isAuthenticated;
		}
	}
}
