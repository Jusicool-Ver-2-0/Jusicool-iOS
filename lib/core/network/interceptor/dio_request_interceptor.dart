import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class DioRequestInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("╔ Body");
    log("║ ${jsonEncode(options.data)}");
    log("╚${'═' * 90}╝");
    super.onRequest(options, handler);
  }
}
