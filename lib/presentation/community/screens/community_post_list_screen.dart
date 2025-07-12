import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import '../controller/community_controller.dart';
import 'community_post_detail_screen.dart';
import 'community_post_write_screen.dart';

class CommunityPostListScreen extends ConsumerStatefulWidget {
  const CommunityPostListScreen({super.key});

  @override
  ConsumerState<CommunityPostListScreen> createState() => _CommunityPostListScreenState();
}

class _CommunityPostListScreenState extends ConsumerState<CommunityPostListScreen> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        _isInitialized = true;
        ref.read(communityControllerProvider.notifier).fetchCommunityPost('general');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityControllerProvider);
    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: AppBar(
        title: Text('커뮤니티', style: JusicoolTypography.subTitle),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.posts.isEmpty
              ? const Center(child: Text('게시글이 없습니다.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CommunityPostDetailScreen(
                              title: post.title,
                              content: post.content,
                              likes: post.likeCount,
                              onDelete: () {
                                // ref.read(communityControllerProvider.notifier)
                                  //  .deletePost(state.selectedMarket, post.id);
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
                            Text(
                              post.title,
                              style: JusicoolTypography.titleSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post.content,
                              style: JusicoolTypography.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '좋아요 ${post.likeCount}',
                                  style: JusicoolTypography.bodySmall.copyWith(
                                    color: JusicoolColor.gray600,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  '댓글 ${post.commentCount}',
                                  style: JusicoolTypography.bodySmall.copyWith(
                                    color: JusicoolColor.gray600,
                                  ),
                                ),
                              ],
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
          if (result != null) {
            // ref.read(communityControllerProvider.notifier).writeCommunityPost(
            //   state.selectedMarket,
            //   result['title'],
            //   result['content'],
            // );
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
