import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_model.dart';

class MovieResultEntity extends Equatable {
  final int page;
  final List<MovieModel> movies;
  final int totalPages;
  final int totalResults;

  MovieResultEntity(
      {required this.page,
      required this.movies,
      required this.totalPages,
      required this.totalResults});

  @override
  List<Object> get props => [movies, totalPages];

  @override
  bool get stringify => true;
}
