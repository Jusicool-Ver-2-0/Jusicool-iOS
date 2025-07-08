import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_entity.freezed.dart';

part 'sign_up_entity.g.dart';

@freezed
abstract class SignUpEntity with _$SignUpEntity {
  const factory SignUpEntity({
    required String email,
    required String password,
    required String name,
    required String school,
  }) = _SignUpEntity;

  factory SignUpEntity.fromJson(Map<String, dynamic> json) =>
      _$SignUpEntityFromJson(json);
}
