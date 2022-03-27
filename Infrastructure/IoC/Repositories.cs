using Microsoft.Extensions.DependencyInjection;
using Repository;
using Repository.Interfaces;

namespace Infrastructure.IoC
{
    public static class Repositories
    {
        public static IServiceCollection Configure(this IServiceCollection services)
        {
            services.AddScoped<IMovieRepository, MovieRepository>();
            services.AddScoped<IRatingRepository, RatingRepository>();
            services.AddScoped<IUserRepository, UserRepository>();

            return services;
        }
    }
}
