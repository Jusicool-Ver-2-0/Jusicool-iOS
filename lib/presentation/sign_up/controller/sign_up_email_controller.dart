import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:jusicool_ios/domain/sign_up/entity/sign_up_email_entity.dart';
import 'package:jusicool_ios/domain/sign_up/usecase/sign_up_usecase.dart';
import 'package:jusicool_ios/presentation/sign_up/mapper/sign_up_email_mapper.dart';
import 'package:jusicool_ios/presentation/sign_up/state/sign_up_email_state.dart';
import '../../../core/config/di/dependencies.dart';

final emailAuthControllerProvider =
    StateNotifierProvider<EmailAuthController, SignUpEmailState>(
      (ref) => EmailAuthController(di.get<SignUpUseCase>()),
    );

class EmailAuthController extends StateNotifier<SignUpEmailState> {
  final SignUpUseCase _signUpUseCase;

  EmailAuthController(this._signUpUseCase) : super(SignUpEmailState()) {
    emailController.addListener(() => _onEmailChanged());
    codeController.addListener(() => _onCodeChanged());
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  static const codeExpirationDuration = Duration(minutes: 5);
  Timer? _codeExpirationTimer;
  Timer? _countdownTimer;

  void disposeResources() {
    _codeExpirationTimer?.cancel();
    _countdownTimer?.cancel();
    emailController.dispose();
    codeController.dispose();
  }

  void _onEmailChanged() {
    final email = emailController.text.trim();
    state = state.copyWith(
      email: email,
      errorMessage: null,
      enableButton: true,
      isEmailValid: true,
    );
  }

  void _onCodeChanged() {
    final code = codeController.text.trim();
    state = state.copyWith(
      verify: code,
      isCodeMatched: true,
      enableButton: true,
    );
  }

  void sendEmail() {
    final email = state.email;
    if (email.isEmpty) {
      state = state.copyWith(
        isEmailValid: false,
        enableButton: false,
        errorMessage: "이메일을 입력해주세요.",
      );
      return;
    }

    if (EmailValidator.validate(email)) {
      state = state.copyWith(
        isEmailValid: true,
        errorMessage: null,
        isSendingCode: true,
      );
      final SignUpEmailEntity request = SignUpEmailMapper.toEntity(state);
      _signUpUseCase
          .sendEmail(request)
          .then((_) {
            _startVerificationTimers();
          })
          .catchError((error) {
            state = state.copyWith(
              isEmailValid: false,
              enableButton: false,
              isSendingCode: false,
              errorMessage: "이메일 전송에 실패했습니다. 잠시 후에 시도해주세요.",
            );
          });
    } else {
      state = state.copyWith(
        isEmailValid: false,
        enableButton: false,
        isSendingCode: false,
        errorMessage: "올바른 이메일 형식이 아닙니다.",
      );
    }
  }

  bool sendVerificationCode() {
    final code = state.verify;
    if (code.isEmpty || code.length != 6) {
      state = state.copyWith(
        isCodeMatched: false,
        enableButton: false,
        errorMessage: "인증번호를 입력해주세요.",
      );
      return false;
    }

    state = state.copyWith(
      isEmailValid: true,
      errorMessage: null,
      isSendingCode: true,
    );
    final request = SignUpEmailMapper.toEntity(state);

    state = state.copyWith(isCodeMatched: true, isSendingCode: false);
    _signUpUseCase
        .verifyEmail(request)
        .then((_) {
          state = state.copyWith(isCodeMatched: true, isSendingCode: false);
          return true;
        })
        .catchError((error) {
          state = state.copyWith(isCodeMatched: false, isSendingCode: false);
          return false;
        });
    return false;
  }

  void _startVerificationTimers() {
    _codeExpirationTimer?.cancel();
    _countdownTimer?.cancel();

    state = state.copyWith(
      codeSent: true,
      isSendingCode: false,
      isCodeMatched: true,
      timeRemaining: codeExpirationDuration,
    );

    codeController.clear();

    _codeExpirationTimer = Timer(codeExpirationDuration, () {
      _countdownTimer?.cancel();
      state = state.copyWith(codeSent: false);
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final seconds = state.timeRemaining.inSeconds;
      if (seconds > 0) {
        state = state.copyWith(timeRemaining: Duration(seconds: seconds - 1));
      } else {
        timer.cancel();
      }
    });
  }
}
