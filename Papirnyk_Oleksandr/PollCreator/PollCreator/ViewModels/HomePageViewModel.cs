using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PollCreator.Models;

namespace PollCreator.ViewModels
{
	public class HomePageViewModel
	{
		public IEnumerable<VoteDto> TopFivePolls { get; set; }
		public string Host { get; set; }
	}
}
