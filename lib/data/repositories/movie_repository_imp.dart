import 'package:dartz/dartz.dart';
import 'package:movie_app/data/data-sources/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_result_model.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImp extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<AppError, MovieResult>> getSearchMovie(String query, int page) async {
    try {
      final moviesResult = await remoteDataSource.getSearchMovie(query, page);
      return Right(moviesResult);
    } on Exception {
      return Left(AppError('Something gone wrong'));
    }
  }
}
