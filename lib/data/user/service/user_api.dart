import 'package:dio/dio.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_verify_email_request_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../dto/remote/request/sign_in_request_dto.dart';
import '../dto/remote/request/sign_up_request_dto.dart';
import '../dto/remote/request/sign_up_send_email_request_dto.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @POST('/user/signin')
  Future<void> signIn(@Body() SignInRequestDto body);

  @POST('/user/signup')
  Future<void> signUp(@Body() SignUpRequestDto body);

  @POST('/user/email/send')
  Future<void> sendEmail(@Body() SignUpSendEmailRequestDto body);

  @POST('/user/email/verify')
  Future<void> verifyEmail(@Body() SignUpVerifyEmailRequestDto body);
}