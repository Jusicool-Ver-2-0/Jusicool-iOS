import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_search_school_entity.freezed.dart';

@freezed
abstract class SignUpSearchSchoolResponseEntity
    with _$SignUpSearchSchoolResponseEntity {
  const factory SignUpSearchSchoolResponseEntity({
    @JsonKey(name: 'schoolInfo') required List<SchoolInfoEntity> schoolInfo,
  }) = _SignUpSearchSchoolResponseEntity;
}

@freezed
abstract class SchoolInfoEntity with _$SchoolInfoEntity {
  const factory SchoolInfoEntity({
    List<dynamic>? head,
    List<SchoolRowEntity>? row,
  }) = _SchoolInfoEntity;
}

@freezed
abstract class SchoolRowEntity with _$SchoolRowEntity {
  const factory SchoolRowEntity({
    @JsonKey(name: 'SCHUL_NM') required String schoolName,
    @JsonKey(name: 'ORG_RDNMA') required String schoolAddress,
  }) = _SchoolRowEntity;
}
