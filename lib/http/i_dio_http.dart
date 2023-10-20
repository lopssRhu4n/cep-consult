import 'package:dio/dio.dart';

abstract class DioHttp {
  final Dio _customDio = Dio();

  static bool wasInitiated = false;

  Dio get dio => _customDio;
}
