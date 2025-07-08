import 'package:jusicool_ios/domain/sign_up/entity/sign_up_email_entity.dart';
import 'package:jusicool_ios/presentation/sign_up/state/sign_up_email_state.dart';

class SignUpEmailMapper {
  static SignUpEmailEntity toEntity(SignUpEmailState state) =>
      SignUpEmailEntity(email: state.email, verifyCode: state.verify);
}
