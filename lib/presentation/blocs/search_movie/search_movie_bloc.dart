import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_result_entity.dart';
import 'package:movie_app/domain/entities/search_params.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;
  SearchMovieBloc({required this.searchMovies}) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchMovieEvent event,
  ) async* {
    if (event is SearchQueryChangedEvent) {
      if (event.searchQuery.length > 2) {
        yield SearchMovieLoading();
        final Either<AppError, MovieResultEntity> response =
            await searchMovies(SearchParams(event.searchQuery, event.page));
        yield response.fold(
          (l) => SearchMovieError(),
          (r) => SearchMovieLoaded(r),
        );
      }
    }
  }
}
