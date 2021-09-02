import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api-client.dart';
import 'package:movie_app/data/data-sources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/movie_repository_imp.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';

final getItInstance = GetIt.I;
Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(() => MovieRepositoryImp(getItInstance()));

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      searchMovies: getItInstance(),
    ),
  );
}
