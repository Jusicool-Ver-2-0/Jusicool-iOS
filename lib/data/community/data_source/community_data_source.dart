import 'package:jusicool_ios/data/community/dto/remote/request/edit_community_post_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/write_community_comment_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/write_community_post_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/response/community_post_detail_response_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/response/community_post_response_dto.dart';

abstract class CommunityDataSource {
  Future<List<CommunityPostResponseDto>> fetchCommunity(String market);

  Future<void> writeCommunityPost(String markte, WriteCommunityPostRequestDto body);

  Future<CommunityPostDetailResponseDto> fetchCommunityDetail(String market, int boardId);

  Future<void> writeComment(String market, int boardId, WriteCommunityCommentRequestDto body);

  Future<void> editPost(String market, int boardId, EditCommunityPostRequestDto body);

  Future<void> likePost(String markte, int boardId);

  Future<void> deletePost(String market, int boardId);
}