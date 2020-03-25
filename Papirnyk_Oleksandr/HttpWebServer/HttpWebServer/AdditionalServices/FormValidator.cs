using System.Collections.Generic;
using WebServerTestAttempt.Interfaces;

namespace WebServerTestAttempt.AdditionalServices
{
	public class FormValidator : IFormValidator
	{
		public bool CheckFormInput(Dictionary<string,string> bodyValues)
		{
			bool isFormSubmittedCorrectly = default(bool);

			if (bodyValues.ContainsKey("user") && bodyValues.ContainsKey("pw"))
			{
				if (!string.IsNullOrWhiteSpace(bodyValues["user"]) && !string.IsNullOrEmpty(bodyValues["pw"]))
				{
					isFormSubmittedCorrectly = true;
				}
			}

			return isFormSubmittedCorrectly;
		}
	}
}
