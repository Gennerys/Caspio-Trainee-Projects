using System.Collections.Generic;
using System.Threading.Tasks;
using PollCreator.Models;

namespace PollCreator.Interfaces.Services
{
	public interface IPollOptionRepository 
	{
		Task Insert(List<PollOptionDto> options, int pollId);
		Task <List<PollOptionDto>> SelectAllForPollPk(int pollId);
	}
}
