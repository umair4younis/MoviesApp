using Moq;
using Business.Interfaces;
using Repository.Interfaces;

namespace Business.Tests.RatingService
{
    public class RatingServiceBase
    {
        protected readonly Mock<IRatingRepository> MockRatingRepository;
        protected readonly Mock<IMovieService> MockMovieService;
        protected readonly Mock<IUserService> MockUserService;

        public RatingServiceBase()
        {
            MockRatingRepository = new Mock<IRatingRepository>();
            MockMovieService = new Mock<IMovieService>();
            MockUserService = new Mock<IUserService>();
        }

        public IRatingService GetService()
        {
            return new Business.RatingService(MockRatingRepository.Object, MockMovieService.Object, MockUserService.Object);
        }
    }
}
