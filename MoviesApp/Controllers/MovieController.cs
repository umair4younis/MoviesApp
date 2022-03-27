using Microsoft.AspNetCore.Mvc;
using Business.Interfaces;
using Domain.DTO;

namespace MoviesApp.Controllers
{
    /// <summary>
    /// movie controller
    /// </summary>
    [Produces("application/json")]
    [Route("api/Movie")]
    public class MovieController : Controller
    {
        private readonly IMovieService _movieService;

        /// <summary>
        /// ctor
        /// </summary>
        /// <param name="movieService"></param>
        public MovieController(IMovieService movieService)
        {
            _movieService = movieService;
        }

        /// <summary>
        /// saves a movie
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST: api/Movie
        ///     {
        ///         "id": 0,
        ///         "title": "string",
        ///         "yearOfRelease": 0,
        ///         "genre": 1,
        ///         "runningTime": 0,
        ///         "averageRating": 0
        ///     }
        ///     
        /// </remarks>
        /// <param name="movie"></param>
        /// <returns>Status result after try to save a movie</returns>
        /// <response code="200">If movie saved successfully</response>
        /// <response code="400">Unable to save the movie</response>
        [HttpPost]
        [ProducesResponseType(200, Type = typeof(Movie))]
        public async Task<IActionResult> Post([FromBody] Movie movie)
        {
            if (await _movieService.SaveMovieAsync(movie))
            {
                return Ok();
            }
            else
            {
                return BadRequest("unable to save movie");
            }
        }
    }
}