import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/sign_up_name_state.dart';

final nameControllerProvider =
    StateNotifierProvider<SignUpNameController, SignUpNameState>(
      (ref) => SignUpNameController(),
    );

class SignUpNameController extends StateNotifier<SignUpNameState> {
  SignUpNameController() : super(SignUpNameState()) {
    _controller.addListener(() => _setUsername(_controller.text));
  }

  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  void _setUsername(String username) {
    state = state.copyWith(username: username);
    if (username.length >= 2) {
      _setEnableButton(true);
    } else {
      _setEnableButton(false);
    }
  }

  void _setEnableButton(bool enable) {
    state = state.copyWith(enableButton: enable);
  }

  bool validateUsername() {
    final username = _controller.text;

    if (username.isEmpty) {
      state = state.copyWith(errorMessage: "이름을 입력해주세요.", enableButton: false);
      return false;
    }

    if (RegExp(r'^[가-힣]{2,}$').hasMatch(username)) {
      state = state.copyWith(errorMessage: null, enableButton: true);
      return true;
    } else {
      state = state.copyWith(
        errorMessage: "올바른 이름 형식이 아닙니다.",
        enableButton: false,
      );
      return false;
    }
  }
}
