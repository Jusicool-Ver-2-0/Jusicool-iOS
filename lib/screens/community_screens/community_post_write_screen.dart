import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_design_system/src/ui/widgets/button/button_medium.dart';

class CommunityPostWriteScreen extends StatefulWidget {
  const CommunityPostWriteScreen({super.key});

  @override
  State<CommunityPostWriteScreen> createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<CommunityPostWriteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  bool get isFormValid =>
      titleController.text.trim().isNotEmpty &&
      contentController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    titleController.addListener(() => setState(() {}));
    contentController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _uploadPost() {
    final title = titleController.text.trim();
    final content = contentController.text.trim();
    if (title.isNotEmpty && content.isNotEmpty) {
      Navigator.pop(context, {'title': title, 'content': content});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('글 작성', style: AppTypography.subTitle),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top -
                80,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요',
                    hintStyle: AppTypography.titleSmall.copyWith(
                      color: AppColor.gray200,
                    ),
                    border: InputBorder.none,
                  ),
                  style: AppTypography.titleSmall,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      hintText: '내용을 입력하세요',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColor.gray200,
                      ),
                      border: InputBorder.none,
                    ),
                    style: AppTypography.bodyMedium,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: AppButtonMedium(
            text: '올리기',
            onPressed: isFormValid ? _uploadPost : null,
            backgroundColor: isFormValid ? AppColor.main : AppColor.gray400,
            textColor: isFormValid ? AppColor.white : AppColor.gray600,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
