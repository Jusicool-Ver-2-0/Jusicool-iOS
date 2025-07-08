import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_send_email_request_dto.freezed.dart';

part 'sign_up_send_email_request_dto.g.dart';

@freezed
abstract class SignUpSendEmailRequestDto with _$SignUpSendEmailRequestDto {
  factory SignUpSendEmailRequestDto({required String email}) =
      _SignUpSendEmailRequestDto;

  factory SignUpSendEmailRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpSendEmailRequestDtoFromJson(json);
}
