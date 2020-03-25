using System.Collections.Generic;

namespace PollCreator.Models
{
	public class VoteRequest
	{
		public IEnumerable<VoteDto> SelectedVotes { get; set; }
		public string PollId { get; set; }
	}
}
