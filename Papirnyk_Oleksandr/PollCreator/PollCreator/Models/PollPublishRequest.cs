using PollCreator.CustomAttributes;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PollCreator.Models
{
	public class PollPublishRequest
	{
		[Required]
		[StringLength(100)]
		public string Title { get; set; }
		[OptionList(2,10)]
		public List<PollOptionDto> Options { get; set; }
		[Required]
		public  bool? IsSingleOption { get; set; }
		[Required]
		public string PollId { get; set; }
		[Required]
		public string EditorToken { get; set; }
	}
}
