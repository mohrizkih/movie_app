part of 'favourite_movie_bloc.dart';

abstract class FavouriteMovieState extends Equatable {
  const FavouriteMovieState();

  @override
  List<Object> get props => [];
}

class FavouriteMovieInitial extends FavouriteMovieState {}

class FavouriteMovieLoaded extends FavouriteMovieState {
  final List<MovieEntity> movies;

  FavouriteMovieLoaded(this.movies);
  @override
  List<Object> get props => [movies];
}

class FavouriteMovieError extends FavouriteMovieState {}

class IsFavouriteMovie extends FavouriteMovieState {
  final bool isMovieFavourite;

  IsFavouriteMovie(this.isMovieFavourite);
  @override
  List<Object> get props => [isMovieFavourite];
}
