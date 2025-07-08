import 'package:jusicool_ios/data/user/data_sources/user_data_source.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_in_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_search_school_request_dto.dart';
import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_verify_email_request_dto.dart';
import 'package:jusicool_ios/data/user/mappers/remote/request/sign_in_request_mapper.dart';
import 'package:jusicool_ios/data/user/mappers/remote/request/sign_up_request_mapper.dart';
import 'package:jusicool_ios/data/user/mappers/remote/request/sign_up_send_email_request_mapper.dart';
import 'package:jusicool_ios/data/user/mappers/remote/request/sign_up_verify_email_request_mapper.dart';
import 'package:jusicool_ios/data/user/mappers/remote/response/sign_up_search_school_response_mapper.dart';
import 'package:jusicool_ios/domain/sign_in/entity/sign_in_entity.dart';
import 'package:jusicool_ios/domain/sign_in/repositories/sign_in_repository.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_email_entity.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_entity.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_search_school_entity.dart';
import 'package:jusicool_ios/domain/sign_up/repositories/sign_up_repository.dart';
import '../dto/remote/request/sign_up_send_email_request_dto.dart';
import '../mappers/remote/request/sign_up_search_school_request_mapper.dart';

class UserRepositoryImpl implements SignInRepository, SignUpRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  @override
  Future<void> signIn(SignInEntity body) async {
    final SignInRequestDto request = SignInRequestMapper.toDto(body);
    return await _userDataSource.signIn(request);
  }

  @override
  Future<void> signUp(SignUpEntity body) async {
    final SignUpRequestDto request = SignUpRequestMapper.toDto(body);
    return await _userDataSource.signUp(request);
  }

  @override
  Future<void> sendEmail(SignUpEmailEntity body) async {
    final SignUpSendEmailRequestDto request =
        SignUpSendEmailRequestMapper.toDto(body);
    return await _userDataSource.sendEmail(request);
  }

  @override
  Future<void> verifyEmail(SignUpEmailEntity entity) async {
    final SignUpVerifyEmailRequestDto request =
        SignUpVerifyEmailRequestMapper.toDto(entity);
    return await _userDataSource.verifyEmail(request);
  }

  @override
  Future<SignUpSearchSchoolResponseEntity> searchSchool(
    String schoolName,
  ) async {
    final SignUpSearchSchoolRequestDto request =
        SignUpSearchSchoolRequestMapper.toDto(schoolName);
    final response = await _userDataSource.searchSchools(request);
    return SignUpSearchSchoolResponseMapper.toEntity(response);
  }
}
