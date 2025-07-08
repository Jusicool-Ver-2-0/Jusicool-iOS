import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_entity.freezed.dart';

part 'exchange_entity.g.dart';

@freezed
abstract class ExchangeEntity with _$ExchangeEntity {
  factory ExchangeEntity({required int amount}) =
      _ExchangeEntity;

  factory ExchangeEntity.fromJson(Map<String, dynamic> json) =>
      _$ExchangeEntityFromJson(json);
}
