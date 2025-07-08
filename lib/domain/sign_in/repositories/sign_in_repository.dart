import 'package:jusicool_ios/domain/sign_in/entity/sign_in_entity.dart';

abstract class SignInRepository {
  Future<void> signIn(SignInEntity entity);
}
