using Moq;
using NUnit.Framework;

namespace Business.Tests.MovieService
{
    [TestFixture]
    public class TopMovies : MovieServiceBase
    {
        [Test]
        public void WhenCalling_TopMovies_WithInvalidMovieCount_ExpectException()
        {
            //arrange/act/assert
            Assert.That(() => GetService().TopMoviesAsync(0), Throws.ArgumentException);
        }

        [TestCase((byte)1)]
        [TestCase((byte)2)]
        public void WhenCalling_TopMovies_WithValidMovieCount_RepositoryMethodCalled(byte movieCount)
        {
            //arrange/act
            var result = GetService().TopMoviesAsync(movieCount);

            //assert
            MockMovieRepository.Verify(s => s.TopMoviesAsync(movieCount), Times.Once);
        }
    }
}
