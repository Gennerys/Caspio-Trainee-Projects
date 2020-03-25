using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PollCreator.Interfaces.Services;
using PollCreator.ViewModels;

namespace PollCreator.Controllers
{
	[Route("~")]
	public class HomeController : Controller
	{
		private IVoteRepository _voteRepository;
		private IRequestHeaderHandler _requestHeaderHandler;

		public HomeController(IVoteRepository voteRepository, IRequestHeaderHandler requestHeaderHandler)
		{
			_voteRepository = voteRepository;
			_requestHeaderHandler = requestHeaderHandler;
		}

		[Route("")]
		[HttpGet]
		public async Task<IActionResult> Index()
		{
			
			HomePageViewModel homePageViewModel = new HomePageViewModel
			{
				TopFivePolls = await _voteRepository.GetTopFivePolls(),
				Host = _requestHeaderHandler.GetHost(ControllerContext)

			};
			return View("Index", homePageViewModel);
		}


	}
}
