import { Injectable, Inject } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { map, catchError } from 'rxjs/operators'
import { of } from 'rxjs'
import { IMovie, IMovieRating } from '../interfaces/movie.interface';


@Injectable({
  providedIn: 'root'
})

export class DataService {
  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) {
  }

  public getTopMovies(topMovieCount: string, userIdApi: string = '') {
    return this.http.get<IMovie[]>(
      this.baseUrl + `api/TopMovies${userIdApi}?movieCount=${topMovieCount}`)
      .pipe(map((result: IMovie | any) => {
        return result;
      }), catchError(error => {
        console.error(error);
        if (error.error instanceof ErrorEvent) {
          return of(`Error: ${error.error.message}`);
        } else {
          return of(this.getServerErrorMessage(error));
        }
      }));
  }

  public getSearchMovies(title: string, yearOfRelease: string, genre: string) {
    let apiSubUri: string = '';
    if (title)
      apiSubUri = apiSubUri.concat(`Title=${title}`);
    if (yearOfRelease) {
      apiSubUri = apiSubUri ? apiSubUri.concat('&') : apiSubUri;
      apiSubUri = apiSubUri.concat(`YearOfRelease=${yearOfRelease}`);
    }
    if (genre) {
      apiSubUri = apiSubUri ? apiSubUri.concat('&') : apiSubUri;
      apiSubUri = apiSubUri.concat(`Genres=${genre}`);
    }

    if (apiSubUri)
      apiSubUri = '?' + apiSubUri;

    return this.http.get<IMovie[]>(
      this.baseUrl + `api/SearchMovies${apiSubUri}`)
      .pipe(map((result: IMovie | any) => {
        return result;
      }), catchError(error => {
        console.error(error);
        if (error.error instanceof ErrorEvent) {
          return of(`Error: ${error.error.message}`);
        } else {
          return of(this.getServerErrorMessage(error));
        }
      }));
  }

  public saveMovie(movieToAdd: IMovie) {
    return this.http.post<IMovie>(this.baseUrl + `api/Movie`, movieToAdd)
      .pipe(map((result: IMovie | any) => {
        return result;
      }), catchError(error => {
        console.error(error);
        if (error.error instanceof ErrorEvent) {
          return of(`Error: ${error.error.message}`);
        } else {
          return of(this.getServerErrorMessage(error));
        }
      }));
  }

  public saveMovieRating(movieRatingToAddOrUpdate: IMovieRating) {
    return this.http.post<IMovieRating>(this.baseUrl + `api/SaveMovieRating`, movieRatingToAddOrUpdate)
      .pipe(map((result: IMovieRating | any) => {
        return result;
      }), catchError(error => {
        console.error(error);
        if (error.error instanceof ErrorEvent) {
          return of(`Error: ${error.error.message}`);
        } else {
          return of(this.getServerErrorMessage(error));
        }
      }));
  }

  private getServerErrorMessage(error: HttpErrorResponse): string {
    switch (error.status) {
      case 400: {
        return `Error ${error.status}: Bad Request with invalid or no parameters provided`;
      }
      case 404: {
        return `Error ${error.status}: Not Found`;
      }
      case 403: {
        return `Error ${error.status}: Access Denied`;
      }
      case 500: {
        return `Error ${error.status}: Internal Server Error`;
      }
      default: {
        return `Error ${error.status}: Unknown Server Error`;
      }
    }
  }
}
