import 'package:hive/hive.dart';
import 'package:movie_app/data/table/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<void> saveMovie(MovieTable movieTable);
  Future<void> deleteMovie(int movieId);
  Future<List<MovieTable>> getMovies();
  Future<bool> isFavourite(int movieId);
}

class MovieLocalDataSourceImp extends MovieLocalDataSource {
  @override
  Future<void> deleteMovie(int movieId) async {
    final movieBox = await Hive.openBox('myMovieBox');
    await movieBox.delete(movieId);
  }

  @override
  Future<List<MovieTable>> getMovies() async {
    final movieBox = await Hive.openBox('myMovieBox');
    final movieId = movieBox.keys;
    List<MovieTable> movies = [];
    movieId.forEach((element) {
      print(element);
      movies.add(movieBox.get(element));
    });
    return movies;
  }

  @override
  Future<bool> isFavourite(int movieId) async {
    final movieBox = await Hive.openBox('myMovieBox');
    return movieBox.containsKey(movieId);
  }

  @override
  Future<void> saveMovie(MovieTable movieTable) async {
    final movieBox = await Hive.openBox('myMovieBox');
    await movieBox.put(movieTable.id, movieTable);
  }
}
