using System.Collections.Generic;
using NUnit.Framework;
using PollCreator.CustomAttributes;
using PollCreator.Models;


namespace PollCreator_Tests
{
	class OptionListAttributeTests
	{
		private OptionListAttribute _optionListAttribute;
		private List<PollOptionDto> _optionList;
		[SetUp]
		public void Setup()
		{
			_optionList = new List<PollOptionDto>();
			_optionListAttribute = new OptionListAttribute(2, 10);
		}

		[Test]
		public void IsValid_ReturnsTrueIfValuesBetweenCorrectScope()
		{
			for (int i = 0; i < 10; i++)
			{
				_optionList.Add(new PollOptionDto());
			}

			var result = _optionListAttribute.IsValid(_optionList);

			Assert.That(result,Is.True);

		}

		[Test]
		public void IsValid_ReturnsFalseIfValuesAreNotInCorrectScope()
		{
			for (int i = 0; i < 12; i++)
			{
				_optionList.Add(new PollOptionDto());
			}
			
			var result = _optionListAttribute.IsValid(_optionList);

			Assert.That(result, Is.False);

		}
	}
}
