using Ninject.Modules;
using WebServerTestAttempt.Controllers;
using WebServerTestAttempt.Interfaces;
using WebServerTestAttempt.Response;
using WebServerTestAttempt.StatusCodeProcessors;

namespace WebServerTestAttempt.AdditionalServices
{
	public class DependencyBindings : NinjectModule
	{
		public override void Load()
		{
			Bind<IMimeTypeResolver>().To<MimeTypeResolver>();
			Bind<IFileService>().To<FileService>();
			Bind<IResponseBuilder>().To<ResponseBuilder>();
			Bind<IResponseHandler>().To<ResponseHandler>();
			Bind<IStatusCodeResponse>().To<StatusCodeResponse>();
			Bind<IUserController>().To<UserController>();
			Bind<IFormValidator>().To<FormValidator>();
			Bind<IFileResponseBuilder>().To<FileResponseBuilder>();
		}
	}
}
