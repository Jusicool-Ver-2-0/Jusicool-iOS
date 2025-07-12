import 'package:jusicool_ios/data/community/data_source/community_data_source_impl.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/edit_community_post_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/write_community_comment_request_dto.dart';
import 'package:jusicool_ios/data/community/dto/remote/request/write_community_post_request_dto.dart';
import 'package:jusicool_ios/data/community/mapper/remote/response/community_post_detail_response_mapper.dart';
import 'package:jusicool_ios/data/community/mapper/remote/response/community_post_response_mapper.dart';
import 'package:jusicool_ios/domain/community/enitites/community_post_detail_entity.dart';
import 'package:jusicool_ios/domain/community/enitites/community_post_entity.dart';
import 'package:jusicool_ios/domain/community/repositories/community_repository.dart';

class CommunityRepositoryImpl extends CommunityRepository {

  final CommunityDataSourceImpl _communityDataSourceImpl;

  CommunityRepositoryImpl(this._communityDataSourceImpl);

  @override
  Future<List<CommunityPostEntity>> fetchCommunity(String market) async {
    final response = await _communityDataSourceImpl.fetchCommunity(market);
    return response.map((e) => CommunityPostResponseMapper.toEntity(e)).toList();
  }

  @override
  Future<void> writeCommunityPost(String market, String title, String content) async {
    final body = WriteCommunityPostRequestDto(title: title, content: content);
    await _communityDataSourceImpl.writeCommunityPost(market, body);
  }

  @override
  Future<List<CommunityPostDetailEntity>> fetchCommunityDetail(String market, int boardId) async {
    final response = await _communityDataSourceImpl.fetchCommunityDetail(market, boardId);
    return [CommunityPostDetailResponseMapper.toEntity(response)];
  }

  @override
  Future<void> writeComment(String market, int boardId, String comment) async {
    final body = WriteCommunityCommentRequestDto(comment: comment);
    await _communityDataSourceImpl.writeComment(market, boardId, body);
  }

  @override
  Future<void> editPost(String market, int boardId, String title, String content) async {
    final body = EditCommunityPostRequestDto(title: title, content: content);
    await _communityDataSourceImpl.editPost(market, boardId, body);
  }

  @override
  Future<void> likePost(String market, int boardId) async {
    await _communityDataSourceImpl.likePost(market, boardId);
  }

  @override
  Future<void> deletePost(String market, int boardId) async {
    await _communityDataSourceImpl.deletePost(market, boardId);
  }

}