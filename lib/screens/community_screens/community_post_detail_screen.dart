import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/screens/community_screens/community_post_edit_screen.dart';

class CommunityPostDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  final VoidCallback? onDelete;

  const CommunityPostDetailScreen({
    super.key,
    required this.post,
    this.onDelete,
  });

  @override
  State<CommunityPostDetailScreen> createState() =>
      _CommunityPostDetailScreenState();
}

class _CommunityPostDetailScreenState extends State<CommunityPostDetailScreen> {
  late Map<String, dynamic> post;
  final List<Map<String, String>> _comments = [];

  @override
  void initState() {
    super.initState();
    post = Map<String, dynamic>.from(widget.post);
  }

  void addComment(String text) {
    setState(() {
      _comments.add({'name': '익명', 'comment': text});
    });
  }

  Widget _buildBottomSheetMenu(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Center(
            child: Text(
              '수정하기',
              style: AppTypography.bodySmall.copyWith(color: AppColor.gray600),
            ),
          ),
          onTap: () async {
            Navigator.pop(context);
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => CommunityPostEditScreen(
                      initialTitle: post['title'],
                      initialContent: post['content'],
                    ),
              ),
            );
            if (result != null && mounted) {
              setState(() {
                post['title'] = result['title'];
                post['content'] = result['content'];
              });
            }
          },
        ),
        ListTile(
          title: Center(
            child: Text(
              '삭제하기',
              style: AppTypography.bodySmall.copyWith(color: AppColor.error),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context, {'deleted': true});
            if (widget.onDelete != null) widget.onDelete!();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('마이크로소프트 커뮤니티', style: AppTypography.subTitle),
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey[100],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => _buildBottomSheetMenu(context),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post['title'] ?? '', style: AppTypography.titleSmall),
            const SizedBox(height: 16),
            Text(post['content'] ?? '', style: AppTypography.bodySmall),
            const SizedBox(height: 16),
            Center(child: LikeButton(initialCount: post['likes'] ?? 0)),
            const SizedBox(height: 24),
            CommentTextField(
              onSubmit: (text) {
                if (text.trim().isNotEmpty) {
                  addComment(text.trim());
                }
              },
            ),
            const SizedBox(height: 16),
            ..._comments.map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CommentItem(name: c['name']!, comment: c['comment']!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final String name;
  final String comment;

  const CommentItem({super.key, required this.name, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppTypography.bodyMedium),
        const SizedBox(height: 4),
        Text(comment, style: AppTypography.bodySmall),
      ],
    );
  }
}

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
              color: isLiked ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              '$likeCount',
              style: TextStyle(
                color: isLiked ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
