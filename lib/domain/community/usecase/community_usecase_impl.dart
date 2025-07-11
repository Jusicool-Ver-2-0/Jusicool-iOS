import 'package:jusicool_ios/domain/community/enitites/community_post_detail_entity.dart';
import 'package:jusicool_ios/domain/community/enitites/community_post_entity.dart';
import 'package:jusicool_ios/domain/community/repositories/community_repository.dart';
import 'package:jusicool_ios/domain/community/usecase/community_usecase.dart';

class CommunityUsecaseImpl extends CommunityUsecase {

  final CommunityRepository _repository;

  CommunityUsecaseImpl(this._repository);

  @override
  Future<List<CommunityPostEntity>> fetchCommunity(String market) async {
    return await _repository.fetchCommunity(market);
  }

  @override
  Future<void> writeCommunityPost(String market,String title,String content) async {
    return await _repository.writeCommunityPost(market,title,content);
  }

  @override
  Future<List<CommunityPostDetailEntity>> fetchCommunityDetail(String market, int boardId) async {
    return await _repository.fetchCommunityDetail(market, boardId);
  }

  @override
  Future<void> editPost(String market, int boardId, String title, String content) async {
    return await _repository.editPost(market, boardId, title, content);
  }

  @override
  Future<void> likePost(String market, int boardId) async {
    return await _repository.likePost(market, boardId);
  }

  @override
  Future<void> writeComment(String market, int boardId, String comment) async {
    return await _repository.writeComment(market, boardId, comment);
  }

  @override
  Future deletePost(String market, int boardId) async {
    return await _repository.deletePost(market, boardId);
  }

}