using System.Collections.Generic;
using WebServerTestAttempt.Interfaces;

namespace WebServerTestAttempt.Controllers
{
	public class UserController : IUserController
	{
		private IFormValidator _formValidator;

		public UserController(IFormValidator formValidator)
		{
			_formValidator = formValidator;
		}

		private Dictionary<string, string> _users = new Dictionary<string, string>()
		{
			{"user1","1111" },
			{"user2","2222" },
			{"user3","3333" }
		};

		private bool CheckUserExistence(string userName, string password)
		{
			bool doesUserExist = _users.ContainsKey(userName) && _users.ContainsValue(password);

			return doesUserExist;
		}

		public bool IsValidUser(Dictionary<string,string> bodyValues)
		{
			bool doesUserExists = false;

			if (_formValidator.CheckFormInput(bodyValues))
			{
				doesUserExists = CheckUserExistence(bodyValues["user"], bodyValues["pw"]);
			}

			return doesUserExists;
		}
	}
}
