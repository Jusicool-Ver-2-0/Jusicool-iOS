import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';

import 'community_post_detail_screen.dart';
import 'community_post_write_screen.dart';

class CommunityPostListScreen extends StatefulWidget {
  const CommunityPostListScreen({super.key});

  @override
  State<CommunityPostListScreen> createState() =>
      _CommunityPostListScreenState();
}

class _CommunityPostListScreenState extends State<CommunityPostListScreen> {
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPostList();
  }

  Future<void> loadPostList() async {
    final jsonStr = await rootBundle.loadString(
      'assets/data/community_post_list.json',
    );
    final data = json.decode(jsonStr);
    setState(() {
      _posts = List<Map<String, dynamic>>.from(data['posts']);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: AppBar(
        title: Text('커뮤니티', style: JusicoolTypography.subTitle),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _posts.isEmpty
              ? const Center(child: Text('게시글이 없습니다.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => CommunityPostDetailScreen(
                                title: post['title'],
                                content: post['content'],
                                onDelete: () {
                                  setState(() {
                                    _posts.removeAt(index);
                                  });
                                },
                              ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: JusicoolColor.gray100,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post['title'], style: JusicoolTypography.titleSmall),
                          const SizedBox(height: 8),
                          Text(
                            post['content'],
                            style: JusicoolTypography.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: JusicoolColor.main,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CommunityPostWriteScreen()),
          );
          if (result != null && mounted) {
            setState(() {
              _posts = [
                {
                  'title': result['title'],
                  'content': result['content'],
                  'likes': 0,
                  'comments': [],
                },
                ..._posts,
              ];
            });
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
