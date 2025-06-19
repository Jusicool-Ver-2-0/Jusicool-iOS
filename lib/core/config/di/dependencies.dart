import 'dart:developer';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jusicool_ios/core/network/api/api_client.dart';
import '../../network/interceptor/cookie_interceptor.dart';

final di = GetIt.instance;

void setDio() {
  try {
    di.registerLazySingleton<Dio>(() => dio());
    di.registerSingletonAsync<CookieJar>(() async => await cookieJar());
    log('✅ :: DIO DI 성공');
  } catch (e) {
    log("⛔ :: DIO DI 실패 \n$e");
  }
}
