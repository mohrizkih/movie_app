import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/core/api-client.dart';
import 'package:movie_app/data/data-sources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/movie_repository_imp.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/delete_favourite_movie.dart';
import 'package:movie_app/domain/usecases/get_favourite_movies.dart';
import 'package:movie_app/domain/usecases/is_favourite_movie.dart';
import 'package:movie_app/domain/usecases/save_favourite_movie.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/presentation/blocs/favourite_movie/favourite_movie_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';

import 'data/data-sources/movie_local_data_source.dart';

final getItInstance = GetIt.I;
Future init() async {
  //Remote
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(() => MovieRepositoryImp(
        getItInstance(),
        getItInstance(),
      ));

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      searchMovies: getItInstance(),
    ),
  );

  //Local
  getItInstance.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImp());
  getItInstance
      .registerLazySingleton<SaveFavouriteMovie>(() => SaveFavouriteMovie(getItInstance()));
  getItInstance
      .registerLazySingleton<DeleteFavouriteMovie>(() => DeleteFavouriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<IsFavourite>(() => IsFavourite(getItInstance()));
  getItInstance
      .registerLazySingleton<GetFavouriteMovies>(() => GetFavouriteMovies(getItInstance()));

  getItInstance.registerFactory(() => FavouriteMovieBloc(
        saveFavouriteMovie: getItInstance(),
        deleteFavouriteMovie: getItInstance(),
        getFavouriteMovies: getItInstance(),
        isFavourite: getItInstance(),
      ));
}
