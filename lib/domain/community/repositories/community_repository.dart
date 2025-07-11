import 'package:jusicool_ios/domain/community/enitites/community_post_detail_entity.dart';
import 'package:jusicool_ios/domain/community/enitites/community_post_entity.dart';

abstract class CommunityRepository {
  Future<List<CommunityPostEntity>> fetchCommunity(String market);

  Future<void> writeCommunityPost(String market, String title, String content);

  Future<List<CommunityPostDetailEntity>> fetchCommunityDetail(String market, int boardId);

  Future<void> writeComment(String market, int boardId, String comment);

  Future<void> editPost(String market, int boardId, String title, String content);

  Future<void> likePost(String market, int boardId);

  Future deletePost(String market, int boardId);
}