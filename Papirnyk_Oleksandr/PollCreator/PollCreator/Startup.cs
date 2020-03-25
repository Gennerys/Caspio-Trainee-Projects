using System.Diagnostics.CodeAnalysis;
using System.IO;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using PollCreator.DataAccess;
using PollCreator.Implementation.Services;
using PollCreator.Interfaces.Services;

namespace PollCreator
{
	[ExcludeFromCodeCoverage]
	public class Startup
	{
		public Startup(IConfiguration configuration)
		{
			Configuration = configuration;
		}

		public IConfiguration Configuration { get; }

		// This method gets called by the runtime. Use this method to add services to the container.
		public void ConfigureServices(IServiceCollection services)
		{
			services.AddControllersWithViews()
				.AddNewtonsoftJson();
			var connectionStringSection =
				Configuration.GetSection("ConnectionStrings");
			services.Configure<ConnectionStringConfig>(connectionStringSection);
			services.AddTransient<ITokenService, TokenService>();
			services.AddTransient<IDataConnection, DataConnection>();
			services.AddTransient<IPollRepository, PollRepository>();
			services.AddTransient<IPollOptionRepository, PollOptionRepository>();
			services.AddTransient<IVoteRepository, VoteRepository>();
			services.AddTransient<IRequestHeaderHandler, RequestHeaderHandler>();

		}

		// This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
		public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ILogger<Startup> logger)
		{
			if (env.IsDevelopment())
			{
				app.UseDeveloperExceptionPage();
			}
			else
			{
				app.UseExceptionHandler(errorApp =>
				{
					errorApp.Run(async context =>
					{
						context.Response.StatusCode = 500;
						context.Response.ContentType = "text/html";

						await context.Response.WriteAsync("<html lang=\"en\"><body>\r\n");
						await context.Response.WriteAsync("ERROR!<br><br>\r\n");

						var exceptionHandlerPathFeature =
							context.Features.Get<IExceptionHandlerPathFeature>();

						logger.LogError(exceptionHandlerPathFeature.Error, exceptionHandlerPathFeature.Path);

						if (exceptionHandlerPathFeature?.Error is FileNotFoundException)
						{
							await context.Response.WriteAsync("File error thrown!<br><br>\r\n");
						}

						await context.Response.WriteAsync("<a href=\"/\">Home</a><br>\r\n");
						await context.Response.WriteAsync("</body></html>\r\n");
						await context.Response.WriteAsync(new string(' ', 512)); // IE padding
					});
				});
			}

			app.UseHttpsRedirection();
			app.UseStaticFiles();
			app.UseRouting();
			app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
			
		}
	}
}
