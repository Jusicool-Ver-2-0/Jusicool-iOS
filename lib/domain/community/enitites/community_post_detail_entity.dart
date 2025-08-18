import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_post_detail_entity.freezed.dart';

@freezed
abstract class CommunityPostDetailEntity with _$CommunityPostDetailEntity {
  factory CommunityPostDetailEntity({
    required int id,
    required String email,
    required String market,
    required String title,
    required String content,
    required List<CommentEntity> comment,
    required int likeCount,
  }) = _CommunityPostDetailEntity;
}

@freezed
abstract class CommentEntity with _$CommentEntity {
  factory CommentEntity({
    required int id,
    required String email,
    required String comment,
  }) = _CommentEntity;
}