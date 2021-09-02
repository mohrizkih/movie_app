import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_result_entity.dart';
import 'package:movie_app/domain/entities/search_params.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class SearchMovies extends UseCase<MovieResultEntity, SearchParams> {
  final MovieRepository movieRepository;

  SearchMovies(this.movieRepository);

  Future<Either<AppError, MovieResultEntity>> call(SearchParams queryParams) async {
    return await movieRepository.getSearchMovie(queryParams.query, queryParams.page);
  }
}
