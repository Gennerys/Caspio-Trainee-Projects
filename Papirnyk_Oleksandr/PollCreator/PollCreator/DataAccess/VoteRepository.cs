using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using PollCreator.Interfaces.Services;
using PollCreator.Models;

namespace PollCreator.DataAccess
{
	public class VoteRepository : IVoteRepository
	{
		private readonly IDataConnection _dataConnection;

		public VoteRepository(IDataConnection dataConnection)
		{
			_dataConnection = dataConnection;
		}

		private async Task<SqlCommand> CreateCommand()
		{
			var connection = await _dataConnection.GetConnection();
			var command = connection.CreateCommand();

			return command;
		}

		public async Task Insert(List<VoteDto> votes, int pollId)
		{
			var sqlText = new StringBuilder();
			foreach (var vote in votes)
			{
				sqlText.Clear();
				sqlText.Append("Insert Into ct_vote (value, poll_id, user_agent, user_ip) ");
				sqlText.Append("Values (@value, @poll_id, @user_agent, @user_ip)");

				using (var command = await CreateCommand())
				{
					command.CommandType = CommandType.Text;
					command.CommandText = sqlText.ToString();
					command.Parameters.AddWithValue("@value", vote.Value);
					command.Parameters.AddWithValue("@poll_id", pollId);
					command.Parameters.AddWithValue("@user_agent", vote.UserAgent);
					command.Parameters.AddWithValue("@user_ip", vote.ClientIp);
					await command.ExecuteNonQueryAsync();
				}
			}
		}

		public async Task<IEnumerable<VoteDto>> CountVotes(int pollId)
		{
			List<VoteDto> votes = new List<VoteDto>();

			using (var command = await CreateCommand())
			{
				var sqlText = new StringBuilder();
				sqlText.Append("Select value, Count(*) as count From ct_vote ");
				sqlText.Append("Where poll_id = @poll_id ");
				sqlText.Append("Group by value ");

				command.CommandType = CommandType.Text;
				command.CommandText = sqlText.ToString();
				command.Parameters.AddWithValue("@poll_id", pollId);

				using (var reader = await command.ExecuteReaderAsync())
				{
					if (!reader.HasRows)
					{
						return votes;
					}

					while (reader.Read())
					{
						if (!reader.IsDBNull(reader.GetOrdinal("value")))
						{
							votes.Add(new VoteDto
							{
								Value = reader.GetString(reader.GetOrdinal("value")),
								Count = reader.GetInt32(1)
							});
						}
					}
					
				}
			}

			return votes;
		}

		public async Task<IEnumerable<VoteDto>> GetTopFivePolls()
		{
			List<VoteDto> votes = new List<VoteDto>();

			using (var command = await CreateCommand())
			{
				var sqlText = new StringBuilder();
				sqlText.Append("Select top(5) Count(*) as count, p.title, p.poll_id From ct_vote as vt ");
				sqlText.Append("Inner join ct_poll as p on vt.poll_id = p.PK_poll_id ");
				sqlText.Append("Group by p.title, p.poll_id ");
				sqlText.Append("Order by count desc ");

				command.CommandType = CommandType.Text;
				command.CommandText = sqlText.ToString();

				using (var reader = await command.ExecuteReaderAsync())
				{
					if (!reader.HasRows)
					{
						return votes;
					}

					while (reader.Read())
					{
						if (!reader.IsDBNull(0) && !reader.IsDBNull(1))
						{
							votes.Add(new VoteDto
							{
								Count = reader.GetInt32(0),
								PollTitle = reader.GetString(1),
								PollId = reader.GetString(2)
							});
						}
					}

				}
			}

			return votes;
		}


		public async Task<IEnumerable<VoteDto>> SelectAllForPollPk(int pollId)
		{
			List<VoteDto> votes = new List<VoteDto>();

			using (var command = await CreateCommand())
			{
				var sqlText = new StringBuilder();
				sqlText.Append("Select  id, value From ct_vote ");
				sqlText.Append("Where poll_id = @poll_id");

				command.CommandType = CommandType.Text;
				command.CommandText = sqlText.ToString();
				command.Parameters.AddWithValue("@poll_id", pollId);

				using (var reader = await command.ExecuteReaderAsync())
				{
					if (!reader.HasRows)
					{
						return votes;
					}
					
					while (reader.Read())
					{
						if (!reader.IsDBNull(reader.GetOrdinal("value")))
						{
							votes.Add(new VoteDto
							{
								Id = reader.GetInt32(reader.GetOrdinal("id")),
								Value = reader.GetString(reader.GetOrdinal("value"))
							});
						}
					}
				}
			}

			return votes;
		}
	}
}
