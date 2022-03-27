using Microsoft.AspNetCore.Mvc;
using Business.Interfaces;
using Domain.DTO;

namespace MoviesApp.Controllers
{
    /// <summary>
    /// Gets top movies by user rating
    /// </summary>
    [Produces("application/json")]
    [Route("api/TopMovies")]
    public class TopMoviesController : Controller
    {
        private readonly IMovieService _movieService;
        private readonly IUserService _userService;

        /// <summary>
        /// ctor
        /// </summary>
        /// <param name="movieService"></param>
        /// <param name="userService"></param>
        public TopMoviesController(IMovieService movieService, IUserService userService)
        {
            _movieService = movieService;
            _userService = userService;
        }

        /// <summary>
        /// Gets top movies as per movie count across all users
        /// </summary>
        /// <param name="movieCount"></param>
        /// <returns>Top movies as per movie count accross all users</returns>
        /// <response code="200">If movies found</response>
        /// <response code="400">If invalid or no parameters provided</response>
        /// <response code="404">If no movies found for the given criteria</response>
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(List<Movie>))]
        public async Task<IActionResult> Get(byte movieCount = 5)
        {
            var movies = await _movieService.TopMoviesAsync(movieCount);

            if (movies == null || !movies.Any())
            {
                return NotFound();
            }

            return Json(movies);
        }

        /// <summary>
        /// Gets top movies as per movie count for a specific user
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="movieCount"></param>
        /// <returns>Top movies as per movie count for a specific user</returns>
        /// <response code="200">If movie found</response>
        /// <response code="400">If invalid or no parameter provided</response>
        /// <response code="404">If the movie is not found for the given criteria</response>
        [HttpGet("userId")]
        [ProducesResponseType(200, Type = typeof(List<Movie>))]
        public async Task<IActionResult> Get(int userId, byte movieCount = 5)
        {
            if (userId <= 0)
            {
                return BadRequest("userId is zero or negative");
            }

            if (!await _userService.UserExistsAsync(userId))
            {
                return BadRequest("userId is invalid");
            }

            var movies = await _movieService.TopMoviesByUserAsync(movieCount, userId);

            if (movies == null || !movies.Any())
            {
                return NotFound();
            }

            return Json(movies);
        }
    }
}