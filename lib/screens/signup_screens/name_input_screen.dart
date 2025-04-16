import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_design_system/src/ui/widgets/textfiled/default_textfiled.dart';
import 'package:jusicool_design_system/src/ui/widgets/button/button_medium.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _controller = TextEditingController();

  bool get _isButtonEnabled => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {}); // 텍스트 변경 시 버튼 상태 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(''),
        elevation: 0,
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이름을 적어 주세요', style: AppTypography.subTitle),
            const SizedBox(height: 24),
            Text('이름', style: AppTypography.bodySmall),
            const SizedBox(height: 8),
            DefaultTextField(
              label: "이름",
              hintText: "실명을 적어주세요",
              validator: (value) {
                if (value == null || value.isEmpty) return '필수 입력 항목입니다.';
                if (!RegExp(r'^[가-힣]{2,}$').hasMatch(value)) {
                  return '한글 이름을 2자 이상 입력해주세요.';
                }
                return null;
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: AppButtonMedium(
                text: "다음",
                onPressed: () {},
                backgroundColor: AppColor.gray300,
                textColor: AppColor.gray600,
                borderColor: AppColor.gray300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
