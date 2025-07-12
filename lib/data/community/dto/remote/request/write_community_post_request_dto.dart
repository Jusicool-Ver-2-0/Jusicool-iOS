import 'package:freezed_annotation/freezed_annotation.dart';

part 'write_community_post_request_dto.g.dart';
part 'write_community_post_request_dto.freezed.dart';

@freezed
abstract class WriteCommunityPostRequestDto with _$WriteCommunityPostRequestDto {
  factory WriteCommunityPostRequestDto({
    required String title,
    required String content,
  }) = _WriteCommunityPostRequestDto;

  factory WriteCommunityPostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$WriteCommunityPostRequestDtoFromJson(json);
}