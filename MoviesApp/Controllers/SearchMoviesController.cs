using Microsoft.AspNetCore.Mvc;
using Business.Interfaces;
using Domain.DTO;
using Domain.Enums.Validation;

namespace MoviesApp.Controllers
{
    /// <summary>
    /// Movie search
    /// </summary>
    [Produces("application/json")]
    [Route("api/SearchMovies")]
    public class SearchMoviesController : Controller
    {
        private readonly IMovieService _movieService;

        /// <summary>
        /// ctor
        /// </summary>
        /// <param name="movieService"></param>
        public SearchMoviesController(IMovieService movieService)
        {
            _movieService = movieService;
        }

        /// <summary>
        /// Searches movies by given criteria
        /// Note: at least one field of the criteria object must be set
        /// </summary>
        /// <param name="criteria"></param>
        /// <returns>Movies which search by given criteria</returns>
        /// <response code="200">If movies found</response>
        /// <response code="400">If no movies found for the given criteria</response>
        /// <response code="404">If invalid or no parameters provided</response>
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(List<Movie>))]
        public async Task<IActionResult> Get(MovieSearchCriteria criteria)
        {
            var validationResult = _movieService.ValidateSearchCriteria(criteria);

            switch (validationResult)
            {
                case MovieSearchValidationResults.InvalidCriteria:
                case MovieSearchValidationResults.NoCriteria:
                    return BadRequest(validationResult.ToString());
            }

            var movies = await _movieService.SearchMoviesAsync(criteria);

            if (movies == null || !movies.Any())
            {
                return NotFound();
            }

            return Json(movies);
        }
    }
}