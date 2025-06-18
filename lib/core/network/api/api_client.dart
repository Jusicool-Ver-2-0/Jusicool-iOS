import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../interceptor/dio_interceptor.dart';

Dio dio() {
  String? _baseUrlDev = dotenv.env['BASE_URL_DEV'];
  String? _baseUrlProd = dotenv.env['BASE_URL_PROD'];
  bool _homeDebugMode = dotenv.env['HOME_DEBUG_MODE'] == 'true';

  if (_baseUrlDev == null || _baseUrlProd == null) {
    throw Exception('BASE_URL_DEV or BASE_URL_PROD is not set in .env file');
  }

  String _baseUrl =
      (kReleaseMode || _homeDebugMode) ? _baseUrlProd : _baseUrlDev;

  Dio dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  dio.interceptors.add(CookieManager(GetIt.I<CookieJar>()));
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: false,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    ),
  );
  dio.interceptors.add(DioErrorInterceptor());
  return dio;
}
