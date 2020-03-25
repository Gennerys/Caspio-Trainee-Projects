namespace PollCreator.Interfaces.Services
{
	public interface ITokenService
	{
		string GetRandomToken(int length);
	}
}
