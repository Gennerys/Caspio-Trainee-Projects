using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Options;
using PollCreator.Interfaces.Services;
using System.Threading.Tasks;

namespace PollCreator.DataAccess
{
	public class DataConnection : IDataConnection
	{
		private SqlConnection _connection;
		private IOptions<ConnectionStringConfig> _connectionStringConfigAccessor;
		public DataConnection(IOptions<ConnectionStringConfig> connectionStringConfigAccessor)
		{
			_connectionStringConfigAccessor = connectionStringConfigAccessor;
		}

		public async Task<SqlConnection> GetConnection()
		{
			_connection = new SqlConnection(_connectionStringConfigAccessor.Value.DefaultConnection);
			 await _connection.OpenAsync();
			
			return _connection;
		}

	}
}
