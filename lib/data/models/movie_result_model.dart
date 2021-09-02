// To parse this JSON data, do
//
//    final movieResult = movieResultFromJson(jsonString);

import 'dart:convert';

import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/entities/movie_result_entity.dart';

class MovieResult extends MovieResultEntity {
  MovieResult({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  }) : super(
          movies: movies,
          page: page,
          totalPages: totalPages,
          totalResults: totalResults,
        );

  final int page;
  final List<MovieModel> movies;
  final int totalPages;
  final int totalResults;

  factory MovieResult.fromRawJson(String str) => MovieResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieResult.fromJson(Map<String, dynamic> json) => MovieResult(
        page: json["page"],
        movies: List<MovieModel>.from(json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(movies.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
