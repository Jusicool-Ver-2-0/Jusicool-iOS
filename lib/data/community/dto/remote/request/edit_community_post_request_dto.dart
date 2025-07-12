import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_community_post_request_dto.g.dart';
part 'edit_community_post_request_dto.freezed.dart';

@freezed
abstract class EditCommunityPostRequestDto with _$EditCommunityPostRequestDto {
  factory EditCommunityPostRequestDto({
    required String title,
    required String content,
  }) = _EditCommunityPostRequestDto;

  factory EditCommunityPostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EditCommunityPostRequestDtoFromJson(json);
}