import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_search_school_request_dto.freezed.dart';

part 'sign_up_search_school_request_dto.g.dart';

@freezed
abstract class SignUpSearchSchoolRequestDto
    with _$SignUpSearchSchoolRequestDto {
  factory SignUpSearchSchoolRequestDto({@Default("") String schoolName}) =
      _SignUpSearchSchoolRequestDto;

  factory SignUpSearchSchoolRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpSearchSchoolRequestDtoFromJson(json);
}
