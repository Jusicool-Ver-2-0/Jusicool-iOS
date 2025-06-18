import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

class CommentItem extends StatelessWidget {
  final String name;
  final String comment;

  const CommentItem({super.key, required this.name, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: JusicoolTypography.bodyMedium),
        const SizedBox(height: 4),
        Text(comment, style: JusicoolTypography.bodySmall),
      ],
    );
  }
}
