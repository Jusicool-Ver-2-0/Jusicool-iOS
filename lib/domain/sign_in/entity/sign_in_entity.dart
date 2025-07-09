import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_entity.freezed.dart';

@freezed
abstract class SignInEntity with _$SignInEntity {
  factory SignInEntity({required String email, required String password}) =
      _SignInEntity;
}
