using Domain.DTO;
using NUnit.Framework;

namespace Business.Tests.MovieService
{
    [TestFixture]
    public class MovieAverageRating
    {
        [TestCase(2.91, 3)]
        [TestCase(3.249, 3)]
        [TestCase(3.25, 3.5)]
        [TestCase(3.6, 3.5)]
        [TestCase(3.75, 4)]
        public void AverageRatingShouldBeRounedCorrectly(decimal averageRating, decimal expectedRoundedValue)
        {
            //arrange
            var movie = new Movie
            {
                AverageRating = averageRating
            };

            //act/assert
            Assert.AreEqual(expectedRoundedValue, movie.AverageRatingForDisplay);
        }
    }
}
