import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:go_router/go_router.dart';

const double BUTTON_HEIGHT = 54;

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
      setState(() {});
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

    context.push('/email-auth', extra: name);
  }

  bool _isValidKoreanName(String name) {
    return RegExp(r'^[가-힣]{2,}$').hasMatch(name);
  }

  Widget buildButton({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    final isEnabled = onPressed != null && !isLoading;

    return Semantics(
      button: true,
      label: label,
      child: Container(
        width: double.infinity,
        height: BUTTON_HEIGHT.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isEnabled ? JusicoolColor.main : JusicoolColor.gray300,
            foregroundColor:
                isEnabled ? JusicoolColor.white : JusicoolColor.gray600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child:
              isLoading
                  ? const CircularProgressIndicator(color: JusicoolColor.white)
                  : Text(
                    label,
                    style: JusicoolTypography.bodyMedium.copyWith(
                      color:
                          isEnabled
                              ? JusicoolColor.white
                              : JusicoolColor.gray600,
                    ),
                  ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w, top: 20.h),
          child: const BackButton(),
        ),
        elevation: 0,
        backgroundColor: JusicoolColor.white,
        foregroundColor: JusicoolColor.black,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 56.h),
        child: Column(
          spacing: 40.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이름을 적어 주세요', style: JusicoolTypography.subTitle),
            Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이름', style: JusicoolTypography.bodySmall),
                DefaultTextField(
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
              ],
            ),
            const Spacer(),
            buildButton(
              label: '다음',
              onPressed: _isButtonEnabled ? _handleNext : null,
            ),
          ],
        ),
      ),
    );
  }
}
