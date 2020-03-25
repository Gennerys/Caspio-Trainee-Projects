using System;
using System.Collections.Generic;

namespace PollCreator.Models
{
	public class PollDto
	{
		public int PrimaryKey { get; set; }
		public string Title { get; set; }
		public bool? IsSingleOption { get; set; }
		public bool IsPublished { get; set; }
		public string PollId { get; set; }
		public string EditorToken { get; set; }
		public DateTime DateOfCreation { get; set; } = DateTime.UtcNow;
		public List<PollOptionDto> Options { get; set; }
	}
}
