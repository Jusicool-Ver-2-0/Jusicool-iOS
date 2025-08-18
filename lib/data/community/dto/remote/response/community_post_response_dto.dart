import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_post_response_dto.g.dart';
part 'community_post_response_dto.freezed.dart';

@freezed
abstract class CommunityPostResponseDto with _$CommunityPostResponseDto {
  factory CommunityPostResponseDto({
    required int id,
    required String email,
    required String market,
    required String title,
    required String content,
    @JsonKey(name: 'comment_count') required int commentCount,
    @JsonKey(name: 'like_count') required int likeCount,
    @JsonKey(name: 'is_liked') required bool isLiked,
  }) = _CommunityPostResponseDto;

  factory CommunityPostResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityPostResponseDtoFromJson(json);
}