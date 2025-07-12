import 'package:jusicool_ios/data/community/data_source/community_data_source.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/edit_community_post_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/write_community_comment_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/write_community_post_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/response/community_post_detail_response_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/response/community_post_response_dto.dart';
import 'package:jusicool_ios/data/community/service/community_api.dart';

class CommunityDataSourceImpl extends CommunityDataSource {

  final CommunityApi _communityApi;

  CommunityDataSourceImpl(this._communityApi);


  @override
  Future<List<CommunityPostResponseDto>> fetchCommunity(String market) async {
    return await _communityApi.fetchCommunity(market);
  }

  @override
  Future<void> writeCommunityPost(String markte, WriteCommunityPostRequestDto body) async {
    return await _communityApi.writeCommunityPost(markte, body);
  }

  @override
  Future<CommunityPostDetailResponseDto> fetchCommunityDetail(String market, int boardId) async {
    return await _communityApi.getCommunityPost(market, boardId);
  }

  @override
  Future<void> writeComment(String market, int boardId, WriteCommunityCommentRequestDto body) async {
    return await _communityApi.writeComment(market, boardId, body);
  }

  @override
  Future<void> editPost(String market, int boardId, EditCommunityPostRequestDto body) async {
    return await _communityApi.editPost(market, boardId, body);
  }

  @override
  Future<void> likePost(String markte, int boardId) async {
    return await _communityApi.likePost(markte, boardId);
  }

  @override
  Future<void> deletePost(String market, int boardId) async {
    return await _communityApi.deletePost(market, boardId);
  }
}