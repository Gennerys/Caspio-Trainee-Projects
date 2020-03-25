using System.Collections.Generic;
using System.Threading.Tasks;
using PollCreator.Models;

namespace PollCreator.Interfaces.Services
{
	public interface IVoteRepository
	{
		Task Insert(List<VoteDto> votes, int pollId);
		Task<IEnumerable<VoteDto>> SelectAllForPollPk(int pollId);
		Task<IEnumerable<VoteDto>> CountVotes(int pollId);
		Task<IEnumerable<VoteDto>> GetTopFivePolls();
	}
}
