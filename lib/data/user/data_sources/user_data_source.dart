import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_search_school_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_send_email_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_verify_email_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/response/sign_up_search_school_response_dto.dart';
import '../dto/remote/request/sign_in_request_dto.dart';
import '../dto/remote/request/sign_up_request_dto.dart';

abstract class UserDataSource {
  Future<void> signIn(SignInRequestDto body);

  Future<void> signUp(SignUpRequestDto body);

  Future<void> sendEmail(SignUpSendEmailRequestDto body);

  Future<void> verifyEmail(SignUpVerifyEmailRequestDto body);

  Future<SignUpSearchSchoolResponseDto> searchSchools(
    SignUpSearchSchoolRequestDto schoolName,
  );
}
