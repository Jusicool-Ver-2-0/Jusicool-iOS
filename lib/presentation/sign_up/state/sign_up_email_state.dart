import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_email_state.freezed.dart';

@freezed
abstract class SignUpEmailState with _$SignUpEmailState {
  factory SignUpEmailState({
    @Default("") String email,
    @Default("") String verify,

    @Default(null) String? errorMessage,
    @Default(false) bool enableButton,

    @Default(true) bool isEmailValid,
    @Default(false) bool codeSent,
    @Default(true) bool isCodeMatched,
    @Default(false) bool isSendingCode,
    @Default(Duration(minutes: 10)) Duration timeRemaining,
  }) = _SignUpEmailState;
}
