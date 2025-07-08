import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_search_school_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_send_email_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_verify_email_request_dto.dart';
import 'package:jusicool_ios/data/user/service/neis_api.dart';
import 'package:jusicool_ios/data/user/service/user_api.dart';
import 'package:jusicool_ios/data/user/data_sources/user_data_source.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_in_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_request_dto.dart';
import '../dto/remote/response/sign_up_search_school_response_dto.dart';

class UserDataSourceImpl extends UserDataSource {
  final UserApi _userApi;
  final NeisApi _neisClient;

  UserDataSourceImpl(this._userApi, this._neisClient);

  @override
  Future<void> signIn(SignInRequestDto body) async {
    return await _userApi.signIn(body);
  }

  @override
  Future<void> signUp(SignUpRequestDto body) async {
    return await _userApi.signUp(body);
  }

  @override
  Future<void> sendEmail(SignUpSendEmailRequestDto body) async {
    return await _userApi.sendEmail(body);
  }

  @override
  Future<void> verifyEmail(SignUpVerifyEmailRequestDto body) async {
    return await _userApi.verifyEmail(body);
  }

  @override
  Future<SignUpSearchSchoolResponseDto> searchSchools(
    SignUpSearchSchoolRequestDto school,
  ) async {
    return await _neisClient.fetchSchools(school.schoolName);
  }
}
