import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie-params.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/delete_favourite_movie.dart';
import 'package:movie_app/domain/usecases/get_favourite_movies.dart';
import 'package:movie_app/domain/usecases/is_favourite_movie.dart';
import 'package:movie_app/domain/usecases/save_favourite_movie.dart';

part 'favourite_movie_event.dart';
part 'favourite_movie_state.dart';

class FavouriteMovieBloc extends Bloc<FavouriteMovieEvent, FavouriteMovieState> {
  final SaveFavouriteMovie saveFavouriteMovie;
  final DeleteFavouriteMovie deleteFavouriteMovie;
  final GetFavouriteMovies getFavouriteMovies;
  final IsFavourite isFavourite;
  FavouriteMovieBloc({
    required this.saveFavouriteMovie,
    required this.deleteFavouriteMovie,
    required this.getFavouriteMovies,
    required this.isFavourite,
  }) : super(FavouriteMovieInitial());

  @override
  Stream<FavouriteMovieState> mapEventToState(
    FavouriteMovieEvent event,
  ) async* {
    if (event is ToggleFavouriteMovieEvent) {
      if (event.isFavourite) {
        await deleteFavouriteMovie(MovieParams(event.movieEntity.id));
      } else {
        await saveFavouriteMovie(event.movieEntity);
      }
      final res = await isFavourite(MovieParams(event.movieEntity.id));
      yield res.fold((l) => FavouriteMovieError(), (r) => IsFavouriteMovie(r));
    } else if (event is LoadFavouriteMovieEvent) {
      yield* _fetchLoadFavoriteMovies();
    } else if (event is DeleteFavouriteMovieEvent) {
      await deleteFavouriteMovie(MovieParams(event.movieId));
      yield* _fetchLoadFavoriteMovies();
    } else if (event is CheckIfFavoriteMovieEvent) {
      final res = await isFavourite(MovieParams(event.movieId));
      yield res.fold((l) => FavouriteMovieError(), (r) => IsFavouriteMovie(r));
    }
  }

  Stream<FavouriteMovieState> _fetchLoadFavoriteMovies() async* {
    final Either<AppError, List<MovieEntity>> response = await getFavouriteMovies(NoParams());

    yield response.fold(
      (l) => FavouriteMovieError(),
      (r) => FavouriteMovieLoaded(r),
    );
  }
}
