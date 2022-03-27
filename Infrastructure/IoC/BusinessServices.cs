using Microsoft.Extensions.DependencyInjection;
using Business;
using Business.Interfaces;

namespace Infrastructure.IoC
{
    public static class BusinessServices
    {
        public static IServiceCollection Configure(this IServiceCollection services)
        {
            services.AddScoped<IMovieService, MovieService>();
            services.AddScoped<IRatingService, RatingService>();
            services.AddScoped<IUserService, UserService>();

            return services;
        }
    }
}
