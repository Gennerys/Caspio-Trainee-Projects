using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PollCreator.Interfaces.Services;
using PollCreator.Models;
using PollCreator.ViewModels;

namespace PollCreator.Controllers
{
	[Route("~/p/")]
	public class PollRendererController : Controller
	{
		private readonly IPollRepository _pollRepository;
		private readonly IPollOptionRepository _pollOptionRepository;
		private readonly IVoteRepository _voteRepository;
		private readonly IRequestHeaderHandler _requestHeaderHandler;

		public PollRendererController(IPollRepository pollRepository, IPollOptionRepository pollOptionRepository,
			IVoteRepository voteRepository, IRequestHeaderHandler requestHeaderHandler)
		{
			_pollRepository = pollRepository;
			_pollOptionRepository = pollOptionRepository;
			_voteRepository = voteRepository;
			_requestHeaderHandler = requestHeaderHandler;
		}

		[Route("{pollId}")]
		[HttpGet]
		public async Task<IActionResult> RenderVotePage([FromRoute]string pollId)
		{
			PollDto pollDto = await _pollRepository.Select(pollId);

			if (pollDto == null)
			{
				return NotFound();
			}

			bool hasVoted = CheckIfUserHasVoted(pollId);

			PollRenderViewModel pollRenderViewModel = new PollRenderViewModel()
			{
				Title = pollDto.Title,
				IsSingleOption = Convert.ToBoolean(pollDto.IsSingleOption),
				Options = await _pollOptionRepository.SelectAllForPollPk(pollDto.PrimaryKey),
				PollId = pollDto.PollId,
				HasVoted = hasVoted
			};

			return View("RenderVotePage", pollRenderViewModel);
		}

		[Route("submit")]
		[HttpPost]
		public async Task<IActionResult> SubmitVote([FromBody] VoteRequest voteRequest)
		{
			bool hasVoted = CheckIfUserHasVoted(voteRequest.PollId);

			if (hasVoted || !voteRequest.SelectedVotes.Any())
			{
				return BadRequest();
			}

			var userAgent = _requestHeaderHandler.GetHeader(ControllerContext, "User-Agent");
			var clientIp = _requestHeaderHandler.GetUserIp(ControllerContext);

			foreach (var vote in voteRequest.SelectedVotes)
			{
				if (vote.Value.Length >= 100)
				{
					vote.Value = vote.Value.Substring(0, 99);
				}
				vote.UserAgent = userAgent;
				vote.ClientIp = clientIp;
			}

			var pollDto = await _pollRepository.Select(voteRequest.PollId);

			if (pollDto == null)
			{
				return NotFound();
			}


			Response.Cookies.Append(voteRequest.PollId, voteRequest.PollId,
				new CookieOptions()
				{
					Expires = DateTime.Now.AddDays(1)
				});
			await _voteRepository.Insert(voteRequest.SelectedVotes.ToList(), pollDto.PrimaryKey);

			return Ok();
		}

		private bool CheckIfUserHasVoted(string pollId)
		{
			bool hasVoted = false;
			var cookieValue = _requestHeaderHandler.GetCookie(ControllerContext, pollId);

			if (cookieValue == pollId)
			{
				hasVoted = true;
			}

			return hasVoted;
		}

		[Route("renderChart")]
		[HttpPost]
		public async Task<IActionResult> RenderPieChart([FromBody] PieChartRequest request)
		{
			bool hasVoted = CheckIfUserHasVoted(request.PollId);

			if (!hasVoted)
			{
				return StatusCode(418);
			}

			var pollDto = await _pollRepository.Select(request.PollId);

			if (pollDto == null)
			{
				return NotFound();
			}

			var votes = await _voteRepository.CountVotes(pollDto.PrimaryKey);

			return new JsonResult(new PieChartDto
			{
				Votes = votes
			});
		}

	}
}
