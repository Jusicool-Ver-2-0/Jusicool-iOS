import 'package:jusicool_ios/data/user/dto/remote/request/sign_in_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_request_dto.dart';

abstract class UserRepository {
  Future<void> signIn(SignInRequestDto body);

  Future<void> signUp(SignUpRequestDto body);

  Future<void> sendEmail();

  Future<void> verifyEmail();
}
