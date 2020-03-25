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
	class PollBuilderControllerTests
	{
		private PollBuilderController _pollBuilderController;
		private ITokenService _tokenService;
		private IPollRepository _pollRepository;
		private IPollOptionRepository _pollOptionRepository;
		private IRequestHeaderHandler _requestHeaderHandler;

		[SetUp]
		public void Setup()
		{
			_tokenService = Substitute.For<ITokenService>();
			_pollRepository = Substitute.For<IPollRepository>();
			_pollOptionRepository = Substitute.For<IPollOptionRepository>();
			_requestHeaderHandler = Substitute.For<IRequestHeaderHandler>();
			_pollBuilderController = new PollBuilderController(_tokenService,_pollRepository,
				_pollOptionRepository,_requestHeaderHandler);
		}

		[Test]
		public async Task Create_CorrectlyRedirectsToEdit()
		{
			string tokenString = "tokenString";
			_tokenService.GetRandomToken(Arg.Any<int>()).Returns(tokenString);
			var result = await _pollBuilderController.Create();

			Assert.AreEqual(2, result.RouteValues.Count, "Check, that we are passing two values: pollId and tokenId");
			Assert.AreEqual("Edit", result.ActionName, "Check, that redirect action is Edit");
			Assert.AreEqual(tokenString, result.RouteValues["pollId"]);
			Assert.AreEqual(tokenString, result.RouteValues["editorId"]);
		}

		[Test]
		public async Task Create_PollRepositoryInsertReceivedCall()
		{
			string tokenString = "tokenString";
			PollDto pollDto = new PollDto();
			_tokenService.GetRandomToken(Arg.Any<int>()).Returns(tokenString);
			await _pollRepository.Insert(pollDto);
			var result = await _pollBuilderController.Create();
			await _pollRepository.Received().Insert(pollDto);

		}

		[Test]
		public async Task Edit_ReturnsBadRequestIfEditorTokensDoNotMatch()
		{
			string tokenString = "tokenString";
			_tokenService.GetRandomToken(Arg.Any<int>()).Returns(tokenString);
			PollDto pollDto = new PollDto()
			{
				IsPublished = true,
				EditorToken = "wrongToken"
			};
			_pollRepository.Select(tokenString).Returns(pollDto);
			await _pollRepository.Select(tokenString);
			var result = await _pollBuilderController.Edit(tokenString, tokenString);
			await _pollRepository.Received().Select(tokenString);
			Assert.IsInstanceOf<BadRequestResult>(result);

		}

		[Test]
		public async Task Edit_PollRenderViewModelIsNotNull()
		{
			string tokenString = "tokenString";
			_tokenService.GetRandomToken(Arg.Any<int>()).Returns(tokenString);
			PollDto pollRenderModel = new PollDto()
			{
				EditorToken = tokenString
			};
			_pollRepository.Select(tokenString).Returns(pollRenderModel);
			await _pollRepository.Select(tokenString);
			await _pollBuilderController.Edit(tokenString, tokenString);
			await _pollRepository.Received().Select(tokenString);
		}


		[Test]
		public async Task Publish_ReturnsBadRequestResultWhenModelStateIsInvalid()
		{
			_pollBuilderController.ModelState.AddModelError("error","Json Parsing failed and we received null");
			var result = await _pollBuilderController.Publish(null);
			Assert.IsInstanceOf<BadRequestResult>(result);
		}

		[Test]
		public async Task Publish_PollRepositoriesReceivingCallsIfModelInDataBase()
		{
			string tokenString = "tokenString";
			_tokenService.GetRandomToken(Arg.Any<int>()).Returns(tokenString);
			PollDto pollDto = new PollDto()
			{
				PollId = tokenString,
				IsPublished = false
			};

			_pollRepository.Select(tokenString).Returns(pollDto);
			
			var pollPublishRequest = new PollPublishRequest()
			{
				EditorToken = tokenString,
				Options = new List<PollOptionDto>(),
				IsSingleOption = true,
				PollId = tokenString,
				Title = "test"
			};
			await _pollBuilderController.Publish(pollPublishRequest);

			var result = await _pollRepository.Select(pollDto.PollId);
			if (!pollDto.IsPublished)
			{
				await _pollRepository.Received().Update(pollDto);
				await _pollOptionRepository.Received().Insert(pollPublishRequest.Options, pollDto.PrimaryKey);
			}

		}


	}
}
