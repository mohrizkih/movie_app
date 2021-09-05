part of 'favourite_movie_bloc.dart';

abstract class FavouriteMovieEvent extends Equatable {
  const FavouriteMovieEvent();
}

class LoadFavouriteMovieEvent extends FavouriteMovieEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteFavouriteMovieEvent extends FavouriteMovieEvent {
  final int movieId;

  DeleteFavouriteMovieEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class ToggleFavouriteMovieEvent extends FavouriteMovieEvent {
  final MovieEntity movieEntity;
  final bool isFavourite;

  ToggleFavouriteMovieEvent(this.movieEntity, this.isFavourite);
  @override
  List<Object?> get props => [movieEntity, isFavourite];
}

class CheckIfFavoriteMovieEvent extends FavouriteMovieEvent {
  final int movieId;

  CheckIfFavoriteMovieEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
