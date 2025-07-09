import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_ios/presentation/sign_up/state/sign_up_password_state.dart';

import '../../../core/config/router/router.dart';

final signupPasswordControllerProvider =
    StateNotifierProvider<SignupPasswordController, SignUpPasswordState>(
      (ref) => SignupPasswordController(),
    );

class SignupPasswordController extends StateNotifier<SignUpPasswordState> {
  SignupPasswordController() : super(const SignUpPasswordState()) {
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  void _onPasswordChanged() {
    final password = _passwordController.text.trim();
    state = state.copyWith(password: password, isPasswordValid: true);
  }

  void _onConfirmPasswordChanged() {
    _updateFormState();
    checkPasswordsMatch();
  }

  void _updateFormState() {
    state = state.copyWith(
      isFormFilled:
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty,
    );
  }

  void validatePassword(String password) {
    state = state.copyWith(isPasswordValid: isValidPassword(password));
  }

  void checkPasswordsMatch() {
    state = state.copyWith(
      isPasswordMatched:
          _passwordController.text == _confirmPasswordController.text,
    );
  }

  bool isValidPassword(String password) {
    if (password.length < 8 || password.length > 13) return false;

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[@$!%*?&]').hasMatch(password);

    final count = [hasLetter, hasNumber, hasSpecial].where((e) => e).length;
    return count >= 2;
  }

  void onNextButtonPressed(BuildContext context) {
    context.push(RoutePaths.findSchool);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
