import 'package:cep_consult/http/i_dio_http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ViaCepAppHttp implements DioHttp {
  static final Dio _customDio = Dio();

  static bool wasInitiated = false;

  @override
  Dio get dio => _customDio;

  ViaCepAppHttp() {
    if (!wasInitiated) {
      _customDio.options.baseUrl = dotenv.get('API_VIA_CEP_BASE_URL');
    }
  }
}
