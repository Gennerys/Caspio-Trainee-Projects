using Microsoft.Data.SqlClient;
using PollCreator.Interfaces.Services;
using PollCreator.Models;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Threading.Tasks;

namespace PollCreator.DataAccess
{
	public class PollOptionRepository : IPollOptionRepository
	{
		private readonly IDataConnection _dataConnection;

		public PollOptionRepository(IDataConnection dataConnection)
		{
			_dataConnection = dataConnection;
		}

		private async Task<SqlCommand> CreateCommand()
		{
			var connection = await _dataConnection.GetConnection();
			var command = connection.CreateCommand();

			return command;
		}

		public async Task Insert(List<PollOptionDto> options, int pollId)
		{
			var sqlText = new StringBuilder();
			foreach (var option in options)
			{
				sqlText.Clear();
				sqlText.Append("Insert Into ct_poll_option (serial_number, value, poll_id) ");
				sqlText.Append("Values (@serial_number, @value, @poll_id)");

				using (var command = await CreateCommand())
				{
					command.CommandType = CommandType.Text;
					command.CommandText = sqlText.ToString();
					command.Parameters.AddWithValue("@serial_number", option.SerialNumber);
					command.Parameters.AddWithValue("@value", option.Value);
					command.Parameters.AddWithValue("@poll_id", pollId);
					await command.ExecuteNonQueryAsync();
				}
			}
		}

		public async Task<List<PollOptionDto>> SelectAllForPollPk(int pollId)
		{
			List<PollOptionDto> options = new List<PollOptionDto>();

			using (var command = await CreateCommand())
			{
				var sqlText = new StringBuilder();
				sqlText.Append("Select serial_number, value From ct_poll_option ");
				sqlText.Append("Where poll_id = @poll_id");

				command.CommandType = CommandType.Text;
				command.CommandText = sqlText.ToString();
				command.Parameters.AddWithValue("@poll_id", pollId);
				
				using (var reader = await command.ExecuteReaderAsync())
				{
					if (!reader.HasRows)
					{
						return options;
					}
					
					while (reader.Read())
					{
						if (!reader.IsDBNull(reader.GetOrdinal("serial_number")) &&
						    !reader.IsDBNull(reader.GetOrdinal("value")))
						{
							options.Add(new PollOptionDto
							{
								SerialNumber = reader.GetInt32(reader.GetOrdinal("serial_number")),
								Value = reader.GetString(reader.GetOrdinal("value"))
							});
						}
					}
				}
			}

			return options;
		}
	}
}
