import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_email_entity.freezed.dart';

@freezed
abstract class SignUpEmailEntity with _$SignUpEmailEntity {
  const factory SignUpEmailEntity({
    required String email,
    required String verifyCode,
  }) = _SignUpEmailEntity;
}
