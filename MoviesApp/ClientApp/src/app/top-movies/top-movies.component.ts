import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatSnackBar } from '@angular/material/snack-bar';

import { DataService } from 'src/app/shared/services/data.service';
import { IMovie, INumberStringOptions } from '../shared/interfaces/movie.interface';
import { genres } from 'src/app/shared/configs/general.config';


@Component({
  selector: 'app-top-movies',
  styleUrls: ['top-movies.component.css'],
  templateUrl: './top-movies.component.html',
})
export class TopMoviesComponent implements OnInit, AfterViewInit {
  public displayedColumns: string[] = ['id', 'title', 'yearOfRelease', 'genre',
    'runningTime', 'averageRating', 'averageRatingForDisplay'];
  public dataSourceTopMovies!: MatTableDataSource<IMovie>;
  public addNewMovieFormGroup!: FormGroup;
  public movieToAdd: IMovie = { title: '' };
  public genres: INumberStringOptions[] = genres;
  public topMovieCount: string = '5';
  public selectedGenre: number = 1;
  private snackBarDurationInSeconds = 5;
  public isLoading = false;

  @ViewChild(MatPaginator) paginatorTopMovies!: MatPaginator;
  @ViewChild(MatSort) sortTopMovies!: MatSort;

  constructor(private formBuilder: FormBuilder, private _snackBar: MatSnackBar, private dataService: DataService) {
    this.getTopMovies(this.topMovieCount);
  }

  ngOnInit() {
    this.addNewMovieFormGroup = this.formBuilder.group({
      titleFormControl: ['', Validators.required],
      yearOfReleaseFormControl: ['', [Validators.required, Validators.min, Validators.max]],
      selectedGenreFormControl: ['', Validators.required],
      runningTimeFormControl: ['', [Validators.required, Validators.min, Validators.max]],
      averageRatingFormControl: ['', [Validators.min, Validators.max]],
      averageRatingForDisplayFormControl: ['', [Validators.min, Validators.max]]
    });
  }

  ngAfterViewInit() {

  }

  dropTopMovies(event: CdkDragDrop<string[]>) {
    moveItemInArray(this.displayedColumns, event.previousIndex, event.currentIndex);
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSourceTopMovies.filter = filterValue.trim().toLowerCase();

    if (this.dataSourceTopMovies.paginator) {
      this.dataSourceTopMovies.paginator.firstPage();
    }
  }

  applyMovieCount(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.getTopMovies(filterValue);
  }

  applyUserFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    if (filterValue)
      this.getTopMovies(this.topMovieCount, `/userId?userId=${filterValue}&`);
  }

  private getTopMovies(topMovieCount: string, userIdApi: string = '') {
    this.isLoading = true;
    this.dataService.getTopMovies(topMovieCount, userIdApi).subscribe(result => {
      this.isLoading = false;
      if (typeof result == 'string') {
        return this.openSnackBar(result, 'Failed');
      }
      this.dataSourceTopMovies = new MatTableDataSource(result);
      this.dataSourceTopMovies.paginator = this.paginatorTopMovies;
      this.dataSourceTopMovies.sort = this.sortTopMovies;
    }, error => {
      console.error(error);
    });
  }

  submitToSaveNewMovie(event: Event) {
    if (this.addNewMovieFormGroup.valid) {
      this.movieToAdd.genre = this.selectedGenre;
      this.dataService.saveMovie(this.movieToAdd).subscribe(result => {
        if (typeof result == 'string') {
          return this.openSnackBar(result, 'Failed');
        }
        this.dataSourceTopMovies.data.push(result);
        return this.openSnackBar('New movie has been added.', 'Success');
      }, error => console.error(error));
    } else {
      this.validateAllFormFields(this.addNewMovieFormGroup);
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
    if (this.addNewMovieFormGroup.get(fieldFormControlName)?.hasError('required')) {
      return 'You must provide a value';
    }

    if (this.addNewMovieFormGroup.get(fieldFormControlName)?.hasError('min')) {
      return 'Value is below minimum';
    }

    return this.addNewMovieFormGroup.get(fieldFormControlName)?.hasError('max') ? 'Value is above maximum' : '';
  }

  isFieldValid(fieldFormControlName: string) {
    return !this.addNewMovieFormGroup.get(fieldFormControlName)?.valid && this.addNewMovieFormGroup.get(fieldFormControlName)?.touched;
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
