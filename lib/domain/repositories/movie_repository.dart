import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';

import '../entities/movie_result_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError, MovieResultEntity>> getSearchMovie(String query, int page);

  Future<Either<AppError, void>> saveMovies(MovieEntity movieEntity);
  Future<Either<AppError, List<MovieEntity>>> getMovies();
  Future<Either<AppError, void>> deleteMovie(int movieId);
  Future<Either<AppError, bool>> isFovourite(int movieId);
}
