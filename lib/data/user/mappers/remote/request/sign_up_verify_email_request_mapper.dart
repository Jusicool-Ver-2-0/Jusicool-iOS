import 'package:jusicool_ios/data/user/dto/remote/request/sign_up_verify_email_request_dto.dart';

import '../../../../../domain/sign_up/entity/sign_up_email_entity.dart';

class SignUpVerifyEmailRequestMapper {
  static SignUpVerifyEmailRequestDto toDto(SignUpEmailEntity entity) =>
      SignUpVerifyEmailRequestDto(email: entity.email, code: entity.verifyCode);
}
