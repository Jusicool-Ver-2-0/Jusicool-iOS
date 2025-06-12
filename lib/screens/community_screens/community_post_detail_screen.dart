import 'package:flutter/material.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_ios/screens/community_screens/community_post_edit_screen.dart';
import 'package:jusicool_ios/widgets/%08comment_textfield.dart';
import 'package:jusicool_ios/widgets/comment_item.dart';
import 'package:jusicool_ios/widgets/like_button.dart';

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
