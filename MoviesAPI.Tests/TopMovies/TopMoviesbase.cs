using Moq;
using MoviesApp.Controllers;
using Business.Interfaces;
using NUnit.Framework;
using System.Threading.Tasks;

namespace MoviesAPI.Tests.TopMovies
{
    public class TopMoviesBase
    {
        protected Mock<IMovieService> MockMovieService;
        protected Mock<IUserService> MockUserService;

        [SetUp]
        protected void Setup()
        {
            MockMovieService = new Mock<IMovieService>();
            MockUserService = new Mock<IUserService>();

            MockUserService.Setup(s => s.UserExistsAsync(It.IsAny<int>())).Returns(Task.FromResult(true));
        }

        protected TopMoviesController GetController()
        {
            return new TopMoviesController(MockMovieService.Object, MockUserService.Object);
        }
    }
}
