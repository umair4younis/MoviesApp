export interface IMovie {
  id?: number;
  title?: string;
  yearOfRelease?: number;
  genre?: number;
  runningTime?: number;
  averageRating?: number;
  averageRatingForDisplay?: number;
}

export interface IMovieRating {
  userId?: number,
  movieId?: number,
  rating?: number
}

export interface INumberStringOptions {
  value: string | number;
  viewValue: string;
}
