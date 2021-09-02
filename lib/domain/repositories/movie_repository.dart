import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';

import '../entities/movie_result_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError, MovieResultEntity>> getSearchMovie(String query, int page);
}
