using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace PollCreator.Interfaces.Services
{
	public interface IDataConnection
	{
		Task<SqlConnection> GetConnection();
	}
}
