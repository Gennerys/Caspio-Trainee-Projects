using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using NSubstitute;
using NUnit.Framework;
using PollCreator.Controllers;
using PollCreator.Interfaces.Services;
using PollCreator.Models;

namespace PollCreator_Tests
{
	class HomeControllerTests
	{
		private HomeController _homeController;
		private IVoteRepository _voteRepository;
		private IRequestHeaderHandler _requestHeaderHandler;
		[SetUp]
		public void Setup()
		{
			_requestHeaderHandler = Substitute.For<IRequestHeaderHandler>();
			_voteRepository = Substitute.For<IVoteRepository>();
			_homeController = new HomeController(_voteRepository,_requestHeaderHandler);
		}

		[Test]
		public async Task Index_ReturnsCorrectView()
		{
			ViewResult viewResult = await _homeController.Index() as ViewResult;
			Assert.AreEqual("Index", viewResult.ViewName);
		}

		[Test]
		public async Task Index_VoteRepositoryReceivedCall()
		{
			_voteRepository.GetTopFivePolls().Returns(new List<VoteDto>
			{
				new VoteDto
				{
					Count = 3
				}
			});

			 await _homeController.Index();
			 await _voteRepository.Received().GetTopFivePolls();

		}
	}
}
