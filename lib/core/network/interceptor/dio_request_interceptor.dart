import 'dart:convert';

import 'package:dio/dio.dart';

class DioRequestInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("╔ Body");
    print("║ ${jsonEncode(options.data)}");
    print("╚${'═' * 90}╝");
    super.onRequest(options, handler);
  }
}
