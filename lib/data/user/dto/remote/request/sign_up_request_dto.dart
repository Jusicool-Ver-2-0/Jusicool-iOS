import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request_dto.g.dart';

part 'sign_up_request_dto.freezed.dart';

@freezed
abstract class SignUpRequestDto with _$SignUpRequestDto {
  factory SignUpRequestDto({
    required String email,
    required String password,
    required String username,
    required String school,
  }) = _SignUpRequestDto;

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestDtoFromJson(json);
}
