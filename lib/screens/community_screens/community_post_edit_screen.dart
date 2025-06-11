import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

class CommunityPostEditScreen extends StatefulWidget {
  final String initialTitle;
  final String initialContent;

  const CommunityPostEditScreen({
    super.key,
    required this.initialTitle,
    required this.initialContent,
  });

  @override
  State<CommunityPostEditScreen> createState() =>
      _CommunityPostEditScreenState();
}

class _CommunityPostEditScreenState extends State<CommunityPostEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    Navigator.pop(context, {
      'title': _titleController.text,
      'content': _contentController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('글 수정', style: AppTypography.subTitle),
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: AppTypography.titleSmall,
              decoration: const InputDecoration(border: InputBorder.none),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: AppTypography.bodySmall,
                decoration: const InputDecoration(border: InputBorder.none),
                maxLines: null,
                expands: true,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.main,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  '수정하기',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
