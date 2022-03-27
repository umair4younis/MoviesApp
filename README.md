MoviesApp

**Pre-requisite Steps:**

Execute the whole SQL script to generate SQL database of the name "Movies" and create the schema and insert test data as well. .\MoviesApp\MoviesApp.Database\RunAll.sql
Update the connection string at line# 20 in the following 2 files for MoviesApp and MoviesAPI projects;

.\MoviesApp\MoviesApp\appsettings.json
.\MoviesApp\MoviesAPI\appsettings.json

Connection string should have the mentioned the Server=your SQL database server name. For example, if your SQL database server name is ABC then the connection string will look like this; 

"DefaultConnection": "Server=ABC;Database=Movies;Trusted_Connection=True;MultipleActiveResultSets=true"



MoviesApp should be set to as startup project for Angular UI based ASP.NET Core frontend.
MoviesAPI can be set to as startup project if Swagger UI for all Movies APIs to explore with API details.

