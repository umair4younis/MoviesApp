using Moq;
using MoviesApp.Controllers;
using Business.Interfaces;
using NUnit.Framework;

namespace MoviesAPI.Tests.Movie
{
    public class MovieBase
    {
        protected Mock<IMovieService> MockMovieService;

        [SetUp]
        protected void Setup()
        {
            MockMovieService = new Mock<IMovieService>();
        }

        protected MovieController GetController()
        {
            return new MovieController(MockMovieService.Object);
        }
    }
}
