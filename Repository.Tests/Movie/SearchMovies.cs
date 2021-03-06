using Domain.DTO;
using Domain.Enums;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Repository.Tests.Movie
{
    [TestFixture]
    public class SearchMovies : MovieRepositoryBase
    {
        [TestCase("action", 1)]
        [TestCase("abc", 3)]
        [TestCase("test", 4)]
        public void Should_HonourMovieTitleFilter(string movieTitle, int expectedMovieCount)
        {
            //arrange/act
            var asyncResult = GetRepository().SearchMoviesAsync(new MovieSearchCriteria { Title = movieTitle });

            //assert
            var result = asyncResult.Result;
            Assert.IsNotNull(result);
            Assert.AreEqual(expectedMovieCount, result.Count);
            Assert.AreEqual(expectedMovieCount, result.Count(m => m.Title.Contains(movieTitle)));
        }


        [TestCase(2001, 1)]
        [TestCase(2000, 2)]
        [TestCase(1999, 4)]
        public void Should_HonourYearOfReleaseFilter(short yearOfrelease, int expectedMovieCount)
        {
            //arrange/act
            var aysncResult = GetRepository().SearchMoviesAsync(new MovieSearchCriteria { YearOfRelease = yearOfrelease });

            //assert
            var result = aysncResult.Result;
            Assert.IsNotNull(result);
            Assert.AreEqual(expectedMovieCount, result.Count);
            Assert.AreEqual(expectedMovieCount, result.Count(m => m.YearOfRelease == yearOfrelease));
        }

        [Test, TestCaseSource(nameof(GenreData))]
        public void Should_HonourGenresFilter(List<Genres> genres, int expectedMovieCount)
        {
            //arrange/act
            var asyncResult = GetRepository().SearchMoviesAsync(new MovieSearchCriteria { Genres = genres });

            //assert
            var result = asyncResult.Result;
            Assert.IsNotNull(result);
            Assert.AreEqual(expectedMovieCount, result.Count);
            Assert.AreEqual(expectedMovieCount, result.Count(m => genres.Contains(m.Genre)));
        }

        [Test, TestCaseSource(nameof(MixFilterData))]
        public void Should_HonourMixedFilter(MovieSearchCriteria searchCriteria, int expectedMovieCount)
        {
            //arrange/act
            var asyncResult = GetRepository().SearchMoviesAsync(searchCriteria);

            //assert
            var result = asyncResult.Result;
            Assert.IsNotNull(result);
            Assert.AreEqual(expectedMovieCount, result.Count);
            Assert.AreEqual(expectedMovieCount, result.Count(m => (string.IsNullOrEmpty(searchCriteria.Title) || m.Title.Contains(searchCriteria.Title))
                && (searchCriteria.YearOfRelease == 0 || m.YearOfRelease == searchCriteria.YearOfRelease)
                && ((searchCriteria.Genres == null || !searchCriteria.Genres.Any()) || searchCriteria.Genres.Contains(m.Genre))));

        }
    }
}
