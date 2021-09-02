import 'package:http/http.dart';

import 'api-constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);
  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    final res = await _client.get(
      getPath(path, params),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw Exception(res.reasonPhrase);
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }
    // print('${ApiConstant.BASE_URL}$path?api_key=${ApiConstant.API_KEY}$paramsString');
    return Uri.parse('${ApiConstant.BASE_URL}$path?api_key=${ApiConstant.API_KEY}$paramsString');
  }
}
