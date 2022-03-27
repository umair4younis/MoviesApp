import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatSnackBar } from '@angular/material/snack-bar';

import { DataService } from 'src/app/shared/services/data.service';
import { IMovie, IMovieRating, INumberStringOptions } from '../shared/interfaces/movie.interface';
import { genres } from 'src/app/shared/configs/general.config';

@Component({
  selector: 'app-search-movie',
  styleUrls: ['search-movie.component.css'],
  templateUrl: './search-movie.component.html',
})
export class SearchMovieComponent implements OnInit, AfterViewInit {
  public displayedColumns: string[] = ['id', 'title', 'yearOfRelease', 'genre',
    'runningTime', 'averageRating', 'averageRatingForDisplay'];
  public dataSourceSearchMovies!: MatTableDataSource<IMovie>;
  public saveMovieRatingFormGroup!: FormGroup;
  public movieRatingToSave: IMovieRating = {};
  public genres: INumberStringOptions[] = genres;
  public titleOfMovie: string = '';
  public yearOfRelease: string = '2012';
  public selectedGenre: string = '';
  private snackBarDurationInSeconds = 5;
  public isLoading = false;

  @ViewChild(MatPaginator) paginatorSearchMovies!: MatPaginator;
  @ViewChild(MatSort) sortSearchMovies!: MatSort;

  constructor(private formBuilder: FormBuilder, private _snackBar: MatSnackBar, private dataService: DataService) {
    this.searchMovies(this.titleOfMovie, this.yearOfRelease, this.selectedGenre);
  }

  ngOnInit() {
    this.saveMovieRatingFormGroup = this.formBuilder.group({
      userIdFormControl: ['', [Validators.required, Validators.min, Validators.max]],
      movieIdFormControl: ['', [Validators.required, Validators.min, Validators.max]],
      movieRatingFormControl: ['', [Validators.required, Validators.min, Validators.max]]
    });
  }

  ngAfterViewInit() {

  }

  dropSearchMovies(event: CdkDragDrop<string[]>) {
    moveItemInArray(this.displayedColumns, event.previousIndex, event.currentIndex);
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSourceSearchMovies.filter = filterValue.trim().toLowerCase();

    if (this.dataSourceSearchMovies.paginator) {
      this.dataSourceSearchMovies.paginator.firstPage();
    }
  }

  applyTitleFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.titleOfMovie = filterValue;
    if (filterValue)
      this.searchMovies(filterValue, this.yearOfRelease, this.selectedGenre);
  }

  applyYearOfReleaseFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.yearOfRelease = filterValue;
    if (filterValue)
      this.searchMovies(this.titleOfMovie, filterValue, this.selectedGenre);
  }

  applyGenreFilter() {
    if (this.selectedGenre)
      this.searchMovies(this.titleOfMovie, this.yearOfRelease, this.selectedGenre);
  }

  private searchMovies(title: string, yearOfRelease: string, genre: string) {
    this.isLoading = true;
    this.dataService.getSearchMovies(title, yearOfRelease, genre).subscribe(result => {
      this.isLoading = false;
      if (typeof result == 'string') {
        return this.openSnackBar(result, 'Failed');
      }

      this.dataSourceSearchMovies = new MatTableDataSource(result);
      this.dataSourceSearchMovies.paginator = this.paginatorSearchMovies;
      this.dataSourceSearchMovies.sort = this.sortSearchMovies;
    }, error => console.error(error));
  }

  submitToSaveNewMovie(event: Event) {
    if (this.saveMovieRatingFormGroup.valid) {
      this.dataService.saveMovieRating(this.movieRatingToSave).subscribe(result => {
        if (typeof result == 'string') {
          return this.openSnackBar(result, 'Failed');
        }
        return this.openSnackBar('Movie rating has been saved.', 'Success');
      }, error => console.error(error));
    } else {
      this.validateAllFormFields(this.saveMovieRatingFormGroup);
    }
  }

  validateAllFormFields(formGroup: FormGroup) {
    Object.keys(formGroup.controls).forEach(field => {
      const control = formGroup.get(field);
      if (control instanceof FormControl) {
        control.markAsTouched({ onlySelf: true });
      } else if (control instanceof FormGroup) {
        this.validateAllFormFields(control);
      }
    });
  }

  getFieldErrorMessage(fieldFormControlName: string) {
    if (this.saveMovieRatingFormGroup.get(fieldFormControlName)?.hasError('required')) {
      return 'You must provide a value';
    }

    if (this.saveMovieRatingFormGroup.get(fieldFormControlName)?.hasError('min')) {
      return 'Value is below minimum';
    }

    return this.saveMovieRatingFormGroup.get(fieldFormControlName)?.hasError('max') ? 'Value is above maximum' : '';
  }

  isFieldValid(fieldFormControlName: string) {
    return !this.saveMovieRatingFormGroup.get(fieldFormControlName)?.valid && this.saveMovieRatingFormGroup.get(fieldFormControlName)?.touched;
  }

  public getGenreViewValue(value: number) {
    if (value)
      return this.genres.find(g => g.value == value)?.viewValue;

    return '';
  }

  openSnackBar(message: string, action: string) {
    this._snackBar.open(message, action, {
      duration: this.snackBarDurationInSeconds * 1000,
    });
  }
}
