import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';

class LikeButton extends StatefulWidget {
  final int initialCount;

  const LikeButton({super.key, this.initialCount = 0});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = widget.initialCount;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleLike,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isLiked ? AppColor.main : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isLiked ? AppColor.main : Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite_border,
              size: 18,
              color: isLiked ? AppColor.white : AppColor.gray400,
            ),
            const SizedBox(width: 4),
            Text(
              '$likeCount',
              style: TextStyle(
                color: isLiked ? AppColor.white : AppColor.gray400,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
