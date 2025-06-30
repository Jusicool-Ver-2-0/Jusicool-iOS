import 'package:jusicool_ios/data/user/api/user_api.dart';
import 'package:jusicool_ios/data/user/data_sources/user_data_source.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_in_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_request_dto.dart';

class UserDataSourceImpl extends UserDataSource {
  final UserApi _userApi;

  UserDataSourceImpl(this._userApi);

  @override
  Future<void> signIn(SignInRequestDto body) async {
    return await _userApi.signIn(body);
  }

  @override
  Future<void> signUp(SignUpRequestDto body) async {
    return await _userApi.signUp(body);
  }

  @override
  Future<void> sendEmail() async {
    return await _userApi.sendEmail();
  }

  @override
  Future<void> verifyEmail() async {
    return await _userApi.verifyEmail();
  }
}
