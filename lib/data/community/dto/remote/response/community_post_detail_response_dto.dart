import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_post_detail_response_dto.g.dart';
part 'community_post_detail_response_dto.freezed.dart';

@freezed
abstract class CommunityPostDetailResponseDto with _$CommunityPostDetailResponseDto {
  factory CommunityPostDetailResponseDto({
    required int id,
    required String email,
    required String market,
    required String title,
    required String content,
    required List<CommentDto> comment,
    @JsonKey(name: 'like_count') required int likeCount,
  }) = _CommunityPostDetailResponseDto;

  factory CommunityPostDetailResponseDto.fromJson(Map<String,dynamic> json) =>
      _$CommunityPostDetailResponseDtoFromJson(json);
}

@freezed
abstract class CommentDto with _$CommentDto {
  factory CommentDto({
    required int id,
    required String email,
    required String comment,
  }) = _CommentDto;

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);
}