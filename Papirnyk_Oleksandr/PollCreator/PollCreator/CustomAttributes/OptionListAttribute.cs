using System.Collections;
using System.ComponentModel.DataAnnotations;

namespace PollCreator.CustomAttributes
{
	public class OptionListAttribute : ValidationAttribute
	{
		private readonly int _minElements;
		private readonly int _maxElements;
		public OptionListAttribute(int minElements, int maxElements)
		{
			_minElements = minElements;
			_maxElements = maxElements;
		}

		public override bool IsValid(object value)
		{
			if (value is IList list)
			{
				return list.Count >= _minElements && list.Count<=_maxElements;
			}
			return false;
		}
	}
}
