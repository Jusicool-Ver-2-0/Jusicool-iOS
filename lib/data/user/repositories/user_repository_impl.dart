import 'package:jusicool_ios/data/user/data_sources/user_data_source.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_in_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_request_dto.dart';
import 'package:jusicool_ios/data/user/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  @override
  Future<void> signIn(SignInRequestDto body) async {
    return await _userDataSource.signIn(body);
  }

  @override
  Future<void> signUp(SignUpRequestDto body) async {
    return await _userDataSource.signUp(body);
  }

  @override
  Future<void> sendEmail() async {
    return await _userDataSource.sendEmail();
  }

  @override
  Future<void> verifyEmail() async {
    return await _userDataSource.verifyEmail();
  }
}
