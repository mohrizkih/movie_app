import 'package:movie_app/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/usecase.dart';

class SaveFavouriteMovie extends UseCase<void, MovieEntity> {
  final MovieRepository movieRepository;

  SaveFavouriteMovie(this.movieRepository);
  @override
  Future<Either<AppError, void>> call(MovieEntity movieEntity) async {
    return await movieRepository.saveMovies(movieEntity);
  }
}
