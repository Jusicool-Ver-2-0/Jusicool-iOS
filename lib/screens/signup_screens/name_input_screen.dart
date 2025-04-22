import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_design_system/src/ui/widgets/textfiled/default_textfiled.dart';
import 'package:jusicool_ios/screens/signup_screens/email_auth_screen.dart';

const double BUTTON_HEIGHT = 48;

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;

  bool get _isButtonEnabled => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _clearErrorOnTextChange();
      setState(() {}); // 버튼 상태 갱신
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearErrorOnTextChange() {
    if (_errorMessage != null) {
      setState(() {
        _errorMessage = null;
      });
    }
  }

  void _handleNext() {
    final name = _controller.text.trim();

    if (name.isEmpty) {
      setState(() {
        _errorMessage = '필수 입력 항목입니다.';
      });
      return;
    }

    if (!_isValidKoreanName(name)) {
      setState(() {
        _errorMessage = '한글 이름을 2자 이상 입력해주세요.';
      });
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EmailAuthScreen()),
    );
  }

  bool _isValidKoreanName(String name) {
    return RegExp(r'^[가-힣]{2,}$').hasMatch(name);
  }

  Widget buildButton({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        width: double.infinity,
        height: BUTTON_HEIGHT.h,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                onPressed != null && !isLoading
                    ? AppColor.main
                    : AppColor.gray300,
            foregroundColor:
                onPressed != null && !isLoading
                    ? AppColor.white
                    : AppColor.gray600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide.none,
            ),
            elevation: 0,
          ),
          child:
              isLoading
                  ? const CircularProgressIndicator(color: AppColor.white)
                  : Text(
                    label,
                    style: AppTypography.bodyMedium.copyWith(
                      color:
                          onPressed != null && !isLoading
                              ? AppColor.white
                              : AppColor.gray600,
                    ),
                  ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(''),
        elevation: 0,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Text('이름을 적어 주세요', style: AppTypography.subTitle),
            ),
            Positioned(
              top: 48.h,
              left: 0,
              child: Text('이름', style: AppTypography.bodySmall),
            ),
            Positioned(
              top: 88.h,
              left: 0,
              right: 0,
              child: DefaultTextField(
                controller: _controller,
                hintText: '실명을 적어주세요',
                validator: (value) {
                  final name = value?.trim() ?? '';
                  if (name.isEmpty) {
                    _errorMessage = '이름을 입력해주세요';
                  } else if (!RegExp(r'^[가-힣]{2,}$').hasMatch(name)) {
                    _errorMessage = '2자 이상 한글로 입력해주세요';
                  } else {
                    _errorMessage = null;
                  }
                  return _errorMessage;
                },
                errorText: _errorMessage,
              ),
            ),
            Positioned(
              bottom: 56.h,
              left: 0,
              right: 0,
              child: buildButton(
                label: '다음',
                onPressed: _isButtonEnabled ? _handleNext : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
