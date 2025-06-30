import 'dart:developer';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jusicool_ios/core/network/api/api_client.dart';
import 'package:jusicool_ios/data/account/api/account_api.dart';
import 'package:jusicool_ios/data/account/data_sources/account_data_source.dart';
import 'package:jusicool_ios/data/user/api/user_api.dart';
import 'package:jusicool_ios/data/user/data_sources/user_data_source.dart';
import '../../../data/account/data_sources/account_data_source_impl.dart';
import '../../../data/account/repositories/account_repository.dart';
import '../../../data/account/repositories/account_repository_impl.dart';
import '../../../data/user/data_sources/user_data_source_impl.dart';
import '../../../data/user/repositories/user_repository.dart';
import '../../../data/user/repositories/user_repository_impl.dart';
import '../../network/interceptor/cookie_interceptor.dart';

final di = GetIt.instance;

void _setDio() {
  try {
    di.registerLazySingleton<Dio>(() => dio());
    di.registerSingletonAsync<CookieJar>(() async => await cookieJar());
    log('✅ :: DIO DI 성공');
  } catch (e) {
    log("⛔ :: DIO DI 실패 \n$e");
  }
}

void _setApi() {
  try {
    di.registerLazySingleton<UserApi>(() => UserApi(di.get<Dio>()));
    di.registerLazySingleton<AccountApi>(() => AccountApi(di.get<Dio>()));
    log('✅ :: API DI 성공');
  } catch (e) {
    log("⛔ :: API DI 실패 \n$e");
  }
}

void _setDataSources() {
  try {
    di.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(di.get<UserApi>()),
    );
    di.registerLazySingleton<AccountDataSource>(
      () => AccountDataSourceImpl(di.get<AccountApi>()),
    );
    log('✅ :: DataSources DI 성공');
  } catch (e) {
    log("⛔ :: DataSources DI 실패 \n$e");
  }
}

void _setRepository() {
  try {
    di.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(di.get<UserDataSource>()),
    );
    di.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(di.get<AccountDataSource>()),
    );
    log('✅ :: Repository DI 성공');
  } catch (e) {
    log("⛔ :: Repository DI 실패 \n$e");
  }
}

void setDependencies() {
  try {
    _setDio();
    _setApi();
    _setDataSources();
    _setRepository();
    log('✅ :: DI 설정 완료');
  } catch (e) {
    log("⛔ :: DI 실패 \n$e");
  }
}
