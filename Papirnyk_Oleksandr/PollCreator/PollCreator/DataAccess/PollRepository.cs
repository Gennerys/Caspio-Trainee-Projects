using System;
using System.Data;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using PollCreator.Interfaces.Services;
using PollCreator.Models;

namespace PollCreator.DataAccess
{
	public class PollRepository : IPollRepository
	{
		private readonly IDataConnection _dataConnection;

		public PollRepository(IDataConnection dataConnection)
		{
			_dataConnection = dataConnection;
		}

		private async Task<SqlCommand> CreateCommand()
		{
			var connection = await _dataConnection.GetConnection();
			var command = connection.CreateCommand();

			return command;
		}

		public async Task<PollDto> Select(string pollId)
		{
			PollDto pollDto = null;

			using (var command = await CreateCommand())
			{
				StringBuilder sqlText = new StringBuilder();
				sqlText.Append(
					"Select PK_poll_id, title, is_single_option, is_published, poll_id, editor_token From ct_poll ");
				sqlText.Append("Where poll_id = @poll_id");

				command.CommandType = CommandType.Text;
				command.CommandText = sqlText.ToString();
				command.Parameters.AddWithValue("@poll_id", pollId);
				using (var reader = await command.ExecuteReaderAsync())
				{
					if (!reader.HasRows)
					{
						pollDto = null;
					}
					
					while (reader.Read())
					{
						if (reader.GetValue(reader.GetOrdinal("poll_id")).ToString() == string.Empty 
						    || reader.GetValue(reader.GetOrdinal("editor_token")).ToString() == string.Empty)
						{
							break;
						}

						pollDto = new PollDto();

						if (!reader.IsDBNull(reader.GetOrdinal("PK_poll_id")))
						{
							pollDto.PrimaryKey = 
								reader.GetInt32(reader.GetOrdinal("PK_poll_id"));
						}
						if (!reader.IsDBNull(reader.GetOrdinal("title")))
						{
							pollDto.Title = 
								reader.GetString(reader.GetOrdinal("title"));
						}
						if (!reader.IsDBNull(reader.GetOrdinal("is_single_option")))
						{
							pollDto.IsSingleOption = 
								reader.GetBoolean(reader.GetOrdinal("is_single_option"));
						}
						if (!reader.IsDBNull(reader.GetOrdinal("is_published")))
						{
							pollDto.IsPublished = 
								reader.GetBoolean(reader.GetOrdinal("is_published"));
						}
						if (!reader.IsDBNull(reader.GetOrdinal("poll_id")))
						{
							pollDto.PollId =
								reader.GetString(reader.GetOrdinal("poll_id"));
						}
						if (!reader.IsDBNull(reader.GetOrdinal("editor_token")))
						{
							pollDto.EditorToken = 
								reader.GetString(reader.GetOrdinal("editor_token"));
						}
					}
				}
			}

			return pollDto;
		}


		public async Task Insert(PollDto poll)
		{
			using (var command = await CreateCommand())
			{
				var sqlText = new StringBuilder();
				sqlText.Append(
					"Insert Into ct_poll (title, is_single_option, is_published, poll_id, editor_token) ");
				sqlText.Append(
					"Values (@title,@is_single_option,@is_published,@poll_id,@editor_token) ");

				command.CommandType = CommandType.Text;
				command.CommandText = sqlText.ToString();
				var titleParameter = new SqlParameter
				{
					ParameterName = "@title",
					SqlDbType = SqlDbType.NVarChar,
					IsNullable = true,
					Direction = ParameterDirection.Input,
					Value = (object)poll.Title ?? DBNull.Value
				};
				var isSingleOptionParameter = new SqlParameter
				{
					ParameterName = "@is_single_option",
					SqlDbType = SqlDbType.Bit,
					IsNullable = true,
					Direction = ParameterDirection.Input,
					Value = (object)poll.IsSingleOption ?? DBNull.Value
				};
				command.Parameters.Add(titleParameter);
				command.Parameters.Add(isSingleOptionParameter);
				command.Parameters.AddWithValue("@is_published", poll.IsPublished);
				command.Parameters.AddWithValue("@poll_id", poll.PollId);
				command.Parameters.AddWithValue("@editor_token", poll.EditorToken);
				await command.ExecuteNonQueryAsync();
			}
		}

		public async Task Update(PollDto poll)
		{
			using (var command = await CreateCommand())
			{
				var sqlText = new StringBuilder();
				sqlText.Append(
					"Update ct_poll SET title = @title,  is_single_option = @is_single_option, is_published = @is_published, date_of_creation = @date_of_creation ");
				sqlText.Append("Where poll_id = @poll_id");

				command.CommandType = CommandType.Text;
				command.CommandText = sqlText.ToString();
				command.Parameters.AddWithValue("@title", poll.Title);
				command.Parameters.AddWithValue("@is_single_option", poll.IsSingleOption);
				command.Parameters.AddWithValue("@is_published", poll.IsPublished);
				command.Parameters.AddWithValue("@poll_id", poll.PollId);
				command.Parameters.AddWithValue("@date_of_creation", poll.DateOfCreation);
				await command.ExecuteNonQueryAsync();
			}
		}
	}
}
