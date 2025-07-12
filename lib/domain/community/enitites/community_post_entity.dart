import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_post_entity.freezed.dart';

@freezed
abstract class CommunityPostEntity with _$CommunityPostEntity {
  factory CommunityPostEntity({
    required int id,
    required String email,
    required String market,
    required String title,
    required String content,
    required int commentCount,
    required int likeCount,
    required bool isLiked,
  }) = _CommunityPostEntity;
}