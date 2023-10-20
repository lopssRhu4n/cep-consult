import 'package:cep_consult/http/i_dio_http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppHttp implements DioHttp {
  static final _customDio = Dio();

  // Making it a singleton
  static bool wasInitiated = false;

  @override
  Dio get dio => _customDio;

  Back4AppHttp() {
    if (!wasInitiated) {
      _customDio.options.headers["X-Parse-Application-Id"] =
          dotenv.get('APP_ID');
      _customDio.options.headers["X-Parse-REST-API-key"] =
          dotenv.get('REST_API_KEY');
      _customDio.options.headers['Content-Type'] = "application/json";
      _customDio.options.baseUrl = dotenv.get('API_BACK4APP_BASE_URL');
      wasInitiated = true;
    }
    // else {
    //   throw Exception('Trying to get to instances of Back4AppHttp');
    // }
  }
}
