namespace PollCreator.Models
{
	public class VoteDto
	{
		public int Id { get; set; }
		public string Value { get; set; }
		public int Count { get; set; }
		public string UserAgent { get; set; }
		public string ClientIp { get; set; }
		public string PollTitle { get; set; }
		public string PollId { get; set; }

	}
}
