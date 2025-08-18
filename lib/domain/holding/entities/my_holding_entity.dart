import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_holding_entity.freezed.dart';

@freezed
abstract class MyHoldingEntity with _$MyHoldingEntity {
  const factory MyHoldingEntity({
    required int id,
    required MarketEntity market,
    required int quantity,
    required int price,
  }) = _MyHoldingEntity;
}

@freezed
abstract class MarketEntity with _$MarketEntity {
  const factory MarketEntity({
    required int id,
    required String koreanName,
    required String englishName,
    required String market,
    required String type,
  }) = _MarketEntity;
}
