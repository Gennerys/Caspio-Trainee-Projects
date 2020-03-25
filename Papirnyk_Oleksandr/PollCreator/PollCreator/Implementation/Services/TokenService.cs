using System;
using System.Linq;
using System.Security.Cryptography;
using PollCreator.Interfaces.Services;

namespace PollCreator.Implementation.Services
{
	public class TokenService : ITokenService
	{
		public string GetRandomToken(int length)
		{
			if (length < 1)
			{
				throw new ArgumentException();
			}
			else
			{
				string alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
				var outOfRange = byte.MaxValue + 1 - (byte.MaxValue + 1) % alphabet.Length;

				return string.Concat(
					Enumerable
						.Repeat(0, int.MaxValue)
						.Select(e => GetRandomByte())
						.Where(randomByte => randomByte < outOfRange)
						.Take(length)
						.Select(randomByte => alphabet[randomByte % alphabet.Length])
				);
			}
		}

		private byte GetRandomByte()
		{
			using (var randomizationProvider = new RNGCryptoServiceProvider())
			{
				var randomBytes = new byte[1];
				randomizationProvider.GetBytes(randomBytes);
				return randomBytes.Single();
			}
		}
	}
}
