import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';

class CommentTextField extends StatefulWidget {
  final void Function(String)? onSubmit;
  const CommentTextField({super.key, this.onSubmit});

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_hasText && widget.onSubmit != null) {
      widget.onSubmit!(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (_) => _submit(),
      decoration: InputDecoration(
        hintText: '댓글을 입력하세요',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: AppColor.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: AppColor.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: AppColor.gray200),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: _hasText ? _submit : null,
            icon: Image.asset(
              'assets/images/ic_arrow_upward.png',
              width: 28,
              height: 28,
              color: _hasText ? AppColor.main : Colors.grey,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
