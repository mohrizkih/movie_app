part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryChangedEvent extends SearchMovieEvent {
  final String searchQuery;
  final int page;

  SearchQueryChangedEvent(this.searchQuery, this.page);

  @override
  List<Object> get props => [searchQuery, page];
}
