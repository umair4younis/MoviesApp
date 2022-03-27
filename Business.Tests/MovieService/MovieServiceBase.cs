using Moq;
using Business.Interfaces;
using Domain.Enums;
using Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Business.Tests.MovieService
{
    public class MovieServiceBase
    {
        protected readonly Mock<IMovieRepository> MockMovieRepository;
        protected readonly Mock<IUserService> MockUserService;

        public MovieServiceBase()
        {
            MockMovieRepository = new Mock<IMovieRepository>();
            MockUserService = new Mock<IUserService>();
        }

        protected IMovieService GetService()
        {
            return new Business.MovieService(MockMovieRepository.Object, MockUserService.Object);
        }

        protected List<Genres> GetGenreList()
        {
            return Enum.GetValues(typeof(Genres)).Cast<Genres>().ToList();
        }
    }
}
