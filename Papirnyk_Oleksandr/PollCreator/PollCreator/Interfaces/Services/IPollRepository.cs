using System.Threading.Tasks;
using PollCreator.Models;

namespace PollCreator.Interfaces.Services
{
	public interface IPollRepository 
	{
		Task Insert(PollDto entity);
		Task Update(PollDto entity);

		Task<PollDto> Select(string pollId);
	}
}
