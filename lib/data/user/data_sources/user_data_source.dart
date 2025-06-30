import 'package:dio/dio.dart';

import '../dto/remote/request/sign_in_request_dto.dart';
import '../dto/remote/request/sign_up_request_dto.dart';

abstract class UserDataSource {

  Future<void> signIn(SignInRequestDto body);

  Future<void> signUp(SignUpRequestDto body);

  Future<void> sendEmail();

  Future<void> verifyEmail();
}
