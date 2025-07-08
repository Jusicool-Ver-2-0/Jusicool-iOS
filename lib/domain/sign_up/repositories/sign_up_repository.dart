import 'package:jusicool_ios/domain/sign_up/entity/sign_up_email_entity.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_entity.dart';

import '../entity/sign_up_search_school_entity.dart';

abstract class SignUpRepository {
  Future<void> signUp(SignUpEntity entity);

  Future<void> sendEmail(SignUpEmailEntity entity);

  Future<void> verifyEmail(SignUpEmailEntity entity);

  Future<SignUpSearchSchoolResponseEntity> searchSchool(String schoolName);
}
