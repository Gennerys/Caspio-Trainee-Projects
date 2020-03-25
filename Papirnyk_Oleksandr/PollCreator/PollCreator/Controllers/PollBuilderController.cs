using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PollCreator.Interfaces.Services;
using PollCreator.Models;
using PollCreator.ViewModels;

namespace PollCreator.Controllers
{
	[Route("~/p/")]
	public class PollBuilderController : Controller
	{
		private readonly ITokenService _tokenService;
		private readonly IPollRepository _pollRepository;
		private readonly IPollOptionRepository _pollOptionRepository;
		private readonly IRequestHeaderHandler _requestHeaderHandler;

		public PollBuilderController(ITokenService tokenService, IPollRepository pollRepository,
			IPollOptionRepository pollOptionRepository, IRequestHeaderHandler requestHeaderHandler)
		{
			_tokenService = tokenService;
			_pollRepository = pollRepository;
			_pollOptionRepository = pollOptionRepository;
			_requestHeaderHandler = requestHeaderHandler;
		}

		[Route("create")]
		[HttpGet]
		public async Task<RedirectToActionResult> Create()
		{
			string pollToken = _tokenService.GetRandomToken(6);
			string editorToken = _tokenService.GetRandomToken(32);

			await _pollRepository.Insert(new PollDto
			{
				Title = null,
				IsSingleOption = null,
				PollId = pollToken,
				EditorToken = editorToken,
				IsPublished = false
			});
			
			return RedirectToAction("Edit",new
			{
				pollId = pollToken,
				editorId = editorToken
			});

		}

		[Route("{pollId}/edit/{editorId}")]
		[HttpGet]
		public async Task<IActionResult> Edit(string pollId, string editorId)
		{
			var pollDto = await _pollRepository.Select(pollId);
			PollBuilderViewModel pollBuilderViewModel = new PollBuilderViewModel
			{
				PollId = pollId,
				EditorToken = editorId,
				Host = _requestHeaderHandler.GetHost(ControllerContext)
			};

			if (pollDto == null)
			{
				return NotFound();
			}
			if (pollDto.EditorToken != editorId)
			{
				return BadRequest();
			}
			if (pollDto.IsPublished) 
			{
				pollBuilderViewModel = new PollBuilderViewModel()
				{
					Title = pollDto.Title,
					IsSingleOption = pollDto.IsSingleOption,
					IsPublished = pollDto.IsPublished,
					PollId = pollDto.PollId,
					EditorToken = pollDto.EditorToken,
					Options = await _pollOptionRepository.SelectAllForPollPk(pollDto.PrimaryKey),
					Host = _requestHeaderHandler.GetHost(ControllerContext)
				};
			}
			return View("Edit", pollBuilderViewModel);
		}

		[HttpPost]
		[Route("publish")]
		public async Task<IActionResult> Publish([FromBody]PollPublishRequest pollPublishRequest)
		{
			if (!ModelState.IsValid)
			{
				return BadRequest();
			}

			var pollDto = await _pollRepository.Select(pollPublishRequest.PollId);

			if (!pollDto.IsPublished)
			{
				pollDto.IsPublished = true;
				pollDto.Title = pollPublishRequest.Title;
				pollDto.IsSingleOption = pollPublishRequest.IsSingleOption;
				pollDto.Options = pollPublishRequest.Options;
				await _pollRepository.Update(pollDto);
				await _pollOptionRepository.Insert(pollPublishRequest.Options, pollDto.PrimaryKey);
			}
			else
			{
				return BadRequest();
			}


			return Ok();
		}
	}
}