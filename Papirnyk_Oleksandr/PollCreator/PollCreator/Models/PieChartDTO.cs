using System.Collections.Generic;

namespace PollCreator.Models
{
	public class PieChartDto
	{
		public IEnumerable<VoteDto> Votes { get; set; }
	}
}
