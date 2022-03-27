using Moq;
using MoviesApp.Controllers;
using Business.Interfaces;
using NUnit.Framework;

namespace MoviesAPI.Tests.SearchMovies
{
    public class SearchMoviesBase
    {
        protected Mock<IMovieService> MockMovieService;

        [SetUp]
        protected void Setup()
        {
            MockMovieService = new Mock<IMovieService>();
        }

        protected SearchMoviesController GetController()
        {
            return new SearchMoviesController(MockMovieService.Object);
        }
    }
}
