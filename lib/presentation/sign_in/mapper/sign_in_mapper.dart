import 'package:jusicool_ios/domain/sign_in/entity/sign_in_entity.dart';
import 'package:jusicool_ios/presentation/sign_in/state/sign_in_state.dart';

class SignInMapper {
  static SignInEntity toEntity(SignInState state) =>
      SignInEntity(email: state.email, password: state.password);
}
