import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_name_state.freezed.dart';

@freezed
abstract class SignUpNameState with _$SignUpNameState {
  factory SignUpNameState({
    @Default("") String username,
    @Default(null) String? errorMessage,
    @Default(false) bool enableButton,
  }) = _SignUpNameState;
}
