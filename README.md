# MoviesApp

Written in Visual Studio 2022, using ASP.NET Core 6.0 with Angular

**Pre-requisite Steps:**
Execute the whole SQL script to generate SQL database of the name "Movies" and create the schema and insert test data as well. .\MoviesApp\MoviesApp.Database\RunAll.sql
Update the connection string at line# 20 in the following 2 files for MoviesApp and MoviesAPI projects;

.\MoviesApp\MoviesApp\appsettings.json
.\MoviesApp\MoviesAPI\appsettings.json

Connection string should have the mentioned the Server=your SQL database server name. For example, if your SQL database server name is ABC then the connection string will look like this;

"DefaultConnection": "Server=ABC;Database=Movies;Trusted_Connection=True;MultipleActiveResultSets=true"


**Set up:**
MoviesApp should be set to as startup project for Angular UI based ASP.NET Core frontend.
MoviesAPI can be set to as startup project if Swagger UI for all Movies APIs to explore with API details.


**Swagger:**
I've used swagger (https://swagger.io) to provide a front end for testing the APIs. The default root for the project is swagger/index.html. I've enabled documentation for swagger so hopefully the swagger UI should provide enough details to use the APIs.

**Search Movies:**
 - End point = /api/SearchMovies
 - Searches movies by given criteria.
 - Input Parameters
	 - Title (string) = movie title (can be partial)
	 - YearOfRelease (short) = year of movie release
	 - Genres (Genres enum) = list of Genres (currently Action: 1, Comedy: 2, Horror: 3, ScienceFiction: 4)
	 - At least one parameter must be set
 - Returns
	 - Movie list as Json
	 - 200 if movies found
	 - 404 if no movies found for the given criteria
	 - 400 if invalid or no parameters provided

**Top Movies**
 - End point = /api/TopMovies{userId}
 - Lists top 5 movies
 - Input Parameters
	 - userId (int) - id of the user to get movie list for
	 - parameter is optional, if not provided will return a list of top movies across all users
 - Returns
 	 - Movie list as Json
	 - 200 if movies found
	 - 404 if no movies found for the given criteria
	 - 400 if invalid or no parameters provided

**Save Movie Rating**
 - End point = /api/SaveMovieRating
 - Saves a movie rating
 - If rating already exists for the user, the new rating value will overwrite the old one
 - Input Parameters
	 - MovieRating Json object
		 - userId (int) - id of the user the rating is for - default scripts will generate users id 1 - 10
		 - movieId (int) - id of the movie the rating is for - default scripts will generate movies id 1 - 40
		 - Rating (byte) - rating value for the movie
 - Returns
	 - 200 if rating saved successfully
	 - 404 if the movie or the user are not found
	 - 400 if the rating Json object is invalid

**Save Movie**
 - End point = /api/Movie
 - Saves a movie
 - Input Parameters
	 - Movie Json object
		 - title (string) = movie title
		 - yearOfRelease (short) = year of movie release
		 - genre (int) = select one enum value based on the list of Genres (currently Action: 1, Comedy: 2, Horror: 3, ScienceFiction: 4)
		 - runningTime (byte) - running time of movie (in minutes)
 - Returns
	 - 200 if movie saved successfully
	 - 400 if the movie Json object is invalid
