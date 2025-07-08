import 'dart:developer';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jusicool_ios/core/network/api/api_client.dart';
import 'package:jusicool_ios/data/user/service/user_api.dart';
import 'package:jusicool_ios/data/user/data_sources/user_data_source.dart';
import 'package:jusicool_ios/domain/sign_in/repositories/sign_in_repository.dart';
import 'package:jusicool_ios/domain/sign_in/usecase/sign_in_usecase.dart';
import 'package:jusicool_ios/domain/sign_in/usecase/sign_in_usecase_impl.dart';
import 'package:jusicool_ios/domain/sign_up/repositories/sign_up_repository.dart';
import 'package:jusicool_ios/domain/sign_up/usecase/sign_up_usecase.dart';
import 'package:jusicool_ios/domain/sign_up/usecase/sign_up_usecase_impl.dart';
import '../../../data/user/data_sources/user_data_source_impl.dart';
import '../../../data/user/repositories/user_repository_impl.dart';
import '../../../data/user/service/neis_api.dart';
import '../../network/interceptor/cookie_interceptor.dart';

final di = GetIt.instance;

void _setDio() {
  try {
    di.registerLazySingleton<Dio>(() => dio());
    di.registerSingletonAsync<CookieJar>(() async => await cookieJar());
    di.registerLazySingleton<Dio>(() => neis(), instanceName: 'neis');
    log('✅ :: DIO DI 성공');
  } catch (e) {
    log("⛔ :: DIO DI 실패 \n$e");
  }
}

void _setApi() {
  try {
    di.registerLazySingleton<UserApi>(() => UserApi(di.get<Dio>()));
    di.registerLazySingleton<NeisApi>(
      () => NeisApi(di.get<Dio>(instanceName: 'neis')),
    );
    log('✅ :: API DI 성공');
  } catch (e) {
    log("⛔ :: API DI 실패 \n$e");
  }
}

void _setDataSources() {
  try {
    di.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(di.get<UserApi>(), di.get<NeisApi>()),
    );
    log('✅ :: DataSources DI 성공');
  } catch (e) {
    log("⛔ :: DataSources DI 실패 \n$e");
  }
}

void _setRepository() {
  try {
    di.registerLazySingleton<SignInRepository>(
      () => UserRepositoryImpl(di.get<UserDataSource>()),
    );
    di.registerLazySingleton<SignUpRepository>(
      () => UserRepositoryImpl(di.get<UserDataSource>()),
    );
    log('✅ :: Repository DI 성공');
  } catch (e) {
    log("⛔ :: Repository DI 실패 \n$e");
  }
}

void _setUseCase() {
  try {
    di.registerLazySingleton<SignInUseCase>(
      () => SignInUseCaseImpl(di.get<SignInRepository>()),
    );
    di.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCaseImpl(di.get<SignUpRepository>()),
    );
    log('✅ :: UseCase DI 성공');
  } catch (e) {
    log("⛔ :: UseCase DI 실패 \n$e");
  }
}

void setDependencies() {
  try {
    _setDio();
    _setApi();
    _setDataSources();
    _setRepository();
    _setUseCase();
    log('✅ :: DI 설정 완료');
  } catch (e) {
    log("⛔ :: DI 실패 \n$e");
  }
}
