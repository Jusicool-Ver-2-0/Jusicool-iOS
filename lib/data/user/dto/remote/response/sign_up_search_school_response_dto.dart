import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_search_school_response_dto.freezed.dart';

part 'sign_up_search_school_response_dto.g.dart';

@freezed
abstract class SignUpSearchSchoolResponseDto
    with _$SignUpSearchSchoolResponseDto {
  const factory SignUpSearchSchoolResponseDto({
    @JsonKey(name: 'schoolInfo') required List<SchoolInfoDto> schoolInfo,
  }) = _SignUpSearchSchoolResponseDto;

  factory SignUpSearchSchoolResponseDto.fromJson(
    Map<String, dynamic> json,
  ) => _$SignUpSearchSchoolResponseDtoFromJson(json);
}

@freezed
abstract class SchoolInfoDto with _$SchoolInfoDto {
  const factory SchoolInfoDto({List<dynamic>? head, List<SchoolRowDto>? row}) =
      _SchoolInfoDto;

  factory SchoolInfoDto.fromJson(Map<String, dynamic> json) =>
      _$SchoolInfoDtoFromJson(json);
}

@freezed
abstract class SchoolRowDto with _$SchoolRowDto {
  const factory SchoolRowDto({
    @JsonKey(name: 'SCHUL_NM') required String schoolName,
    @JsonKey(name: 'ORG_RDNMA') required String schoolAddress,
  }) = _SchoolRowDto;

  factory SchoolRowDto.fromJson(Map<String, dynamic> json) =>
      _$SchoolRowDtoFromJson(json);
}
