import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie-params.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class DeleteFavouriteMovie extends UseCase<void, MovieParams> {
  final MovieRepository movieRepository;

  DeleteFavouriteMovie(this.movieRepository);
  @override
  Future<Either<AppError, void>> call(MovieParams movieParams) async {
    return await movieRepository.deleteMovie(movieParams.id);
  }
}
