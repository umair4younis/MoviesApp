using Moq;
using MoviesApp.Controllers;
using Business.Interfaces;
using NUnit.Framework;

namespace MoviesAPI.Tests.SaveMovieRating
{
    public class SaveMovieRatingBase
    {
        protected Mock<IRatingService> MockRatingService;

        public SaveMovieRatingBase()
        {
            MockRatingService = new Mock<IRatingService>();
        }

        [SetUp]
        protected void SetUp()
        {

        }

        protected SaveMovieRatingController GetController()
        {
            return new SaveMovieRatingController(MockRatingService.Object);
        }
    }
}
