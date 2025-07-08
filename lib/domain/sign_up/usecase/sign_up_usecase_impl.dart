import 'package:jusicool_ios/domain/sign_up/entity/sign_up_email_entity.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_entity.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_search_school_entity.dart';
import 'package:jusicool_ios/domain/sign_up/usecase/sign_up_usecase.dart';

import '../repositories/sign_up_repository.dart';

class SignUpUseCaseImpl extends SignUpUseCase {
  final SignUpRepository _signUpRepository;

  SignUpUseCaseImpl(this._signUpRepository);

  @override
  Future<void> signUp(SignUpEntity entity) {
    return _signUpRepository.signUp(entity);
  }

  @override
  Future<void> sendEmail(SignUpEmailEntity entity) {
    return _signUpRepository.sendEmail(entity);
  }

  @override
  Future<void> verifyEmail(SignUpEmailEntity entity) {
    return _signUpRepository.verifyEmail(entity);
  }

  @override
  Future<SignUpSearchSchoolResponseEntity> searchSchool(String schoolName) {
    return _signUpRepository.searchSchool(schoolName);
  }
}
