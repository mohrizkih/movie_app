import 'package:movie_app/data/core/api-client.dart';
import 'package:movie_app/data/models/movie_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResult> getSearchMovie(String query, int page);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<MovieResult> getSearchMovie(String query, int page) async {
    final res = await _client.get('search/movie', params: {
      'query': query,
      'page': page,
    });
    final movieResult = MovieResult.fromRawJson(res);
    print(movieResult);
    return movieResult;
  }
}
