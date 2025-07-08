import 'package:jusicool_ios/domain/sign_up/entity/sign_up_email_entity.dart';

import '../../../dto/remote/request/sign_up_send_email_request_dto.dart';

class SignUpSendEmailRequestMapper {
  static SignUpSendEmailRequestDto toDto(SignUpEmailEntity entity) =>
      SignUpSendEmailRequestDto(email: entity.email);
}
