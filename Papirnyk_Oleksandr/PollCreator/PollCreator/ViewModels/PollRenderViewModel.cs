using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using PollCreator.Models;

namespace PollCreator.ViewModels
{
	public class PollRenderViewModel
	{
		public string Title { get; set; }
		public bool IsSingleOption { get; set; }
		public IEnumerable<PollOptionDto> Options { get; set; }

		[HiddenInput]
		public string PollId { get; set; }

		[HiddenInput]
		public  bool HasVoted { get; set; }
	}
}
