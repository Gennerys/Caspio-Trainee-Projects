using NUnit.Framework;
using System;
using System.Collections.Generic;
using PollCreator.Implementation.Services;


namespace PollCreator_Tests
{
	class TokenServiceTests
	{
		private TokenService _tokenService;

		[SetUp]
		public void Setup()
		{
			_tokenService = new TokenService();
		}

		[Test]
		public void GetRandomToken_ReturnsRandomStringOfSpecifiedLength()
		{
			List<string> tokens = new List<string>();

			//Act
			for (int i = 10; i <= 30; i+=10)
			{
				tokens.Add(_tokenService.GetRandomToken(i));
			}

			//Assert
			int k = 10;
			foreach (var token in tokens)
			{
				Assert.That(token.Length, Is.EqualTo(k));
				k += 10;
			}

		}

		[Test]
		public void GetRandomToken_ReturnsEmptyStringIfPassZero()
		{
			
			Assert.Throws<ArgumentException>(() => { _tokenService.GetRandomToken(0);});
		}

		[Test]
		public void GetRandomToken_ReturnsEmptyStringIfPassNegative()
		{
			Assert.Throws<ArgumentException>(() => { _tokenService.GetRandomToken(-1); });
		}

	}
}
