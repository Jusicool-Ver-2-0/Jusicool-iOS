import 'package:freezed_annotation/freezed_annotation.dart';

part 'write_community_comment_request_dto.g.dart';
part 'write_community_comment_request_dto.freezed.dart';

@freezed
abstract class WriteCommunityCommentRequestDto with _$WriteCommunityCommentRequestDto {
  factory WriteCommunityCommentRequestDto({
    required String comment,
  }) = _WriteCommunityPostRequestDto;

  factory WriteCommunityCommentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$WriteCommunityCommentRequestDtoFromJson(json);
}