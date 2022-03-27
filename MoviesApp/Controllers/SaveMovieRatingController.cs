using Microsoft.AspNetCore.Mvc;
using Business.Interfaces;
using Domain.DTO;
using Domain.Enums.Validation;

namespace MoviesApp.Controllers
{
    /// <summary>
    /// Saves movie ratings
    /// </summary>
    [Produces("application/json")]
    [Route("api/SaveMovieRating")]
    public class SaveMovieRatingController : Controller
    {
        private readonly IRatingService _ratingService;

        /// <summary>
        /// ctor
        /// </summary>
        /// <param name="ratingService"></param>
        public SaveMovieRatingController(IRatingService ratingService)
        {
            _ratingService = ratingService;
        }

        /// <summary>
        /// saves a movie rating
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST: api/SaveMovieRating
        ///     {
        ///         "userId": 0,
        ///         "movieId": 0,
        ///         "rating": 0
        ///     }
        ///     
        /// </remarks>
        /// <param name="movieRating"></param>
        /// <returns>Status result after try to save a movie rating</returns>
        /// <response code="200">If rating saved successfully</response>
        /// <response code="400">If the movie or the user are not found</response>
        /// <response code="404">If the rating Json object is invalid</response>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] MovieRating movieRating)
        {
            var validationResult = await _ratingService.ValidateMovieRatingAsync(movieRating);

            switch (validationResult)
            {
                case MovieRatingSaveValidationResults.OK:
                    if (await _ratingService.SaveRatingAsync(movieRating))
                    {
                        return Ok();
                    }
                    else
                    {
                        return BadRequest("couldn't save rating");
                    }
                case MovieRatingSaveValidationResults.NullRating:
                case MovieRatingSaveValidationResults.InvalidMovieId:
                case MovieRatingSaveValidationResults.InvalidUserId:
                    return BadRequest(validationResult.ToString());
                case MovieRatingSaveValidationResults.MovieNotfound:
                case MovieRatingSaveValidationResults.UserNotFound:
                    return NotFound(validationResult.ToString());
            }

            return BadRequest("unknown validation failure");
        }
    }
}