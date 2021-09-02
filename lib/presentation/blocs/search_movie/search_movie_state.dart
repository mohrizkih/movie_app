part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoaded extends SearchMovieState {
  final MovieResultEntity movieResultEntity;

  SearchMovieLoaded(this.movieResultEntity);

  @override
  List<Object> get props => [movieResultEntity];
}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {}
