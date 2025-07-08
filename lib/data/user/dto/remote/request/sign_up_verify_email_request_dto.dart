import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_verify_email_request_dto.freezed.dart';

part 'sign_up_verify_email_request_dto.g.dart';

@freezed
abstract class SignUpVerifyEmailRequestDto with _$SignUpVerifyEmailRequestDto {
  factory SignUpVerifyEmailRequestDto({
    required String email,
    required String code,
  }) = _SignUpVerifyEmailRequestDto;

  factory SignUpVerifyEmailRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpVerifyEmailRequestDtoFromJson(json);
}
