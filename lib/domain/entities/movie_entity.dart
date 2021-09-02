import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String? backdropPath;
  final int id;
  final String? overview;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final double voteAverage;

  MovieEntity({
    required this.backdropPath,
    required this.id,
    this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;
}
