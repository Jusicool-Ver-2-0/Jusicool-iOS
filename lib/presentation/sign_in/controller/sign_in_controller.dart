import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jusicool_ios/domain/sign_in/usecase/sign_in_usecase.dart';
import '../../../core/config/di/dependencies.dart';
import '../mapper/sign_in_mapper.dart';
import '../state/sign_in_state.dart';

final signInControllerProvider =
    StateNotifierProvider<UserSignInController, SignInState>(
      (ref) => UserSignInController(di.get<SignInUseCase>()),
    );

class UserSignInController extends StateNotifier<SignInState> {
  final SignInUseCase _signInUseCase;

  UserSignInController(this._signInUseCase) : super(SignInState()) {
    _emailController.addListener(() {
      _setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _setPassword(_passwordController.text);
    });
  }

  bool _isValidPassword(String password) {
    if (password.length < 8 || password.length > 13) return false;

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[@$!%*?&]').hasMatch(password);

    int satisfiedConditions =
        [hasLetter, hasNumber, hasSpecial].where((e) => e).length;

    return satisfiedConditions >= 2;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  void _setEmail(String email) {
    state = state.copyWith(email: email);
    if (email.isNotEmpty && EmailValidator.validate(email)) {
      _clearError();
    } else {
      _setEnableButton(false);
    }
  }

  void _setPassword(String password) {
    state = state.copyWith(password: password);
    if (password.isNotEmpty && _isValidPassword(password)) {
      _clearError();
    } else {
      _setEnableButton(false);
    }
  }

  void _setError(String message) {
    state = state.copyWith(hasError: true, errorMessage: message);
  }

  void _clearError() {
    state = state.copyWith(hasError: false, errorMessage: "");
    _setEnableButton(true);
  }

  void _setEnableButton(bool enable) {
    state = state.copyWith(enableButton: enable);
  }

  Future<bool> signIn() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      _setError("이메일과 비밀번호를 입력해주세요.");
      return false;
    }
    if (!EmailValidator.validate(state.email)) {
      _setError("유효한 이메일을 입력해주세요.");
      return false;
    }
    if (!_isValidPassword(state.password)) {
      _setError("비밀번호는 8~13자이며, 문자, 숫자, 특수문자 중 2가지 이상 포함해야 합니다.");
      return false;
    }

    _clearError();

    try {
      final request = SignInMapper.toEntity(state);
      await _signInUseCase.signIn(request);
      return true;
    } catch (error) {
      _setError("아이디와 비밀번호를 다시 한 번 확인해주세요");
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
