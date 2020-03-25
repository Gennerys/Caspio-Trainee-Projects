using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NSubstitute;
using NUnit.Framework;
using PollCreator.Controllers;
using PollCreator.Interfaces.Services;
using PollCreator.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace PollCreator_Tests
{
	class PollRendererControllerTests
	{
		private PollRendererController _pollRendererController;
		private IPollRepository _pollRepository;
		private IPollOptionRepository _pollOptionRepository;
		private IVoteRepository _voteRepository;
		private IRequestHeaderHandler _requestHeaderHandler;
		private int primaryKey;

		[SetUp]
		public void Setup()
		{
			primaryKey = 123;
			_pollRepository = Substitute.For<IPollRepository>();
			_pollOptionRepository = Substitute.For<IPollOptionRepository>();
			_voteRepository = Substitute.For<IVoteRepository>();
			_requestHeaderHandler = Substitute.For<IRequestHeaderHandler>();

			_pollRendererController = new PollRendererController(_pollRepository, _pollOptionRepository,
				_voteRepository, _requestHeaderHandler);
			_pollRepository.Select(Arg.Any<string>()).Returns(new PollDto());
			_pollOptionRepository.SelectAllForPollPk(Arg.Any<int>()).Returns(new List<PollOptionDto>());
			_pollRendererController.ControllerContext.HttpContext = new DefaultHttpContext();
			_pollRendererController.ControllerContext.HttpContext.Request.Headers["someId"] = "someId";
			_requestHeaderHandler.GetHeader(_pollRendererController.ControllerContext, "User-Agent").Returns("someAgent");
			_requestHeaderHandler.GetUserIp(_pollRendererController.ControllerContext).Returns("someIp");
		}

		[Test]
		public async Task RenderVotePage_ReturnsCorrectView()
		{
			string pollId = "someId";
			_pollRepository.Select(pollId).Returns(new PollDto()
			{
				PollId = pollId,
				PrimaryKey = primaryKey
			});
		
			var viewResult = await _pollRendererController.RenderVotePage(pollId) as ViewResult;

			Assert.AreEqual("RenderVotePage", viewResult.ViewName);
		}

		[Test]
		public async Task RenderVotePage_PollRepositoryReceivedCalls()
		{
			string pollId = "someId";
			await _pollRendererController.RenderVotePage(pollId);
			_pollRepository.Select(pollId).Returns(new PollDto()
			{
				PollId = pollId,
				PrimaryKey = primaryKey
			});

			var result = await _pollRepository.Select(pollId);
			await _pollRepository.Received().Select(pollId);
		}

		[Test]
		public async Task RenderVotePage_ReturnsNotFoundIfPollDoesNotExist()
		{
			string pollId = "someId";
			PollDto pollDto = null;
			_pollRepository.Select(pollId).Returns(pollDto);

			var result = await _pollRendererController.RenderVotePage(pollId);

			Assert.IsInstanceOf<NotFoundResult>(result);
		}

		[Test]
		public async Task Submit_ReturnsBadRequestIfSelectedValuesZero()
		{
			string pollId = "someId";
			var result =  await _pollRendererController.SubmitVote(new VoteRequest()
			{
				PollId = pollId,
				SelectedVotes = new List<VoteDto>()
			});

			Assert.IsInstanceOf<BadRequestResult>(result);
		}
		[Test]
		public async Task Submit_ReturnsBadRequestIfUserAlreadyVoted()
		{
			string pollId = "someId";
			_requestHeaderHandler.GetCookie(_pollRendererController.ControllerContext, pollId).Returns(pollId);
			var result = await _pollRendererController.SubmitVote(new VoteRequest()
			{
				PollId = pollId,
				SelectedVotes = new List<VoteDto>()
				{
					new VoteDto()
					{
						Count = 1
					}
				}
			});

			Assert.IsInstanceOf<BadRequestResult>(result);
		}

		[Test]
		public async Task Submit_ReturnsNotFoundIfPollWasNotFound()
		{

			string pollId = "someId";
			_requestHeaderHandler.GetCookie(_pollRendererController.ControllerContext, pollId).Returns("");
			PollDto pollDto = null;
			_pollRepository.Select(pollId).Returns(pollDto);
			

			var result = await _pollRendererController.SubmitVote(new VoteRequest()
			{
				PollId = pollId,
				SelectedVotes = new List<VoteDto>()
				{
					new VoteDto()
					{
						Count = 1,
						Value = "test"
					}
				}
			});
			await _pollRepository.Select(pollId);

			Assert.IsInstanceOf<NotFoundResult>(result);
		}

		[Test]
		public async Task Submit_ReturnsOkIfPollExists()
		{
			string pollId = "someId";
			PollDto pollDto = new PollDto();
			_requestHeaderHandler.GetCookie(_pollRendererController.ControllerContext, pollId).Returns("");
			_pollRepository.Select(pollId).Returns(pollDto);
			VoteRequest voteRequest = new VoteRequest()
			{
				PollId = pollId,
				SelectedVotes = new List<VoteDto>()
				{
					new VoteDto()
					{
						Count = 1,
						Value = "test"
					}
				}
			};
			var result = await _pollRendererController.SubmitVote(voteRequest);

			Assert.IsInstanceOf<OkResult>(result);
		}

		[Test]
		public async Task RenderPieChart_ReturnsTeapotIfUserHasNotVoted()
		{
			string pollId = "someId";
			_requestHeaderHandler.GetCookie(_pollRendererController.ControllerContext, pollId).Returns("");

			var result = await _pollRendererController.RenderPieChart(new PieChartRequest() { PollId = pollId });

			Assert.IsInstanceOf<StatusCodeResult>(result);
		}

		[Test]
		public async Task RenderPieChart_ReturnsNotFoundIfPollWasNotFound()
		{
			string pollId = "someId";
			PollDto pollDto = null;
			_requestHeaderHandler.GetCookie(_pollRendererController.ControllerContext, pollId).Returns(pollId);
			_pollRepository.Select(pollId).Returns(pollDto);

			var result = await _pollRendererController.RenderPieChart(new PieChartRequest(){PollId = pollId});
			await _pollRepository.Select(pollId);

			Assert.IsInstanceOf<NotFoundResult>(result);
		}

		[Test]
		public async Task RenderPieChart_ReturnsJsonResultIfPollWasFound()
		{
			string pollId = "someId";
			PollDto pollDto = new PollDto();
			_requestHeaderHandler.GetCookie(_pollRendererController.ControllerContext, pollId).Returns(pollId);
			_pollRepository.Select(pollId).Returns(pollDto);

			var result = await _pollRendererController.RenderPieChart(new PieChartRequest() { PollId = pollId });
			await _pollRepository.Select(pollId);

			Assert.IsInstanceOf<JsonResult>(result);
		}
	}
}
