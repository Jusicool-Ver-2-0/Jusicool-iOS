import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_password_state.freezed.dart';

@freezed
abstract class SignUpPasswordState with _$SignUpPasswordState {
  const factory SignUpPasswordState({
    @Default('') String password,
    @Default(true) bool isPasswordValid,
    @Default(true) bool isPasswordMatched,
    @Default(true) bool isFormFilled,
  }) = _SignUpPasswordState;
}
