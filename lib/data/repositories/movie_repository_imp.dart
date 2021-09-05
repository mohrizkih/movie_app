import 'package:dartz/dartz.dart';
import 'package:movie_app/data/data-sources/movie_local_data_source.dart';
import 'package:movie_app/data/data-sources/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_result_model.dart';
import 'package:movie_app/data/table/movie_table.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImp extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImp(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<AppError, MovieResult>> getSearchMovie(String query, int page) async {
    try {
      final moviesResult = await remoteDataSource.getSearchMovie(query, page);
      return Right(moviesResult);
    } on Exception {
      return Left(AppError('Something gone wrong'));
    }
  }

  @override
  Future<Either<AppError, void>> deleteMovie(int movieId) async {
    try {
      final res = await localDataSource.deleteMovie(movieId);
      return Right(res);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getMovies() async {
    try {
      final res = await localDataSource.getMovies();
      return Right(res);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, bool>> isFovourite(int movieId) async {
    try {
      final res = await localDataSource.isFavourite(movieId);
      return Right(res);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> saveMovies(MovieEntity movieEntity) async {
    try {
      final res = await localDataSource.saveMovie(MovieTable.fromMovieEntity(movieEntity));
      return Right(res);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}
