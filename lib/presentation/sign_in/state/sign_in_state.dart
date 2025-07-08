import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  factory SignInState({
    @Default("") String email,
    @Default("") String password,
    @Default(false) bool enableButton,
    @Default(false) bool hasError,
    @Default("") String errorMessage,
  }) = _SignInState;
}
