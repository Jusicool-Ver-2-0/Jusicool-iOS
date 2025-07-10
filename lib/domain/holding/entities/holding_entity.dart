import 'package:freezed_annotation/freezed_annotation.dart';

part 'holding_entity.freezed.dart';

@freezed
abstract class HoldingEntity with _$HoldingEntity {
  const factory HoldingEntity({
    required int id,
    required MarketEntity market,
    required int quantity,
    required int price,
  }) = _HoldingEntity;
}

@freezed
abstract class MarketEntity with _$MarketEntity {
  const factory MarketEntity({
    required int id,
    @JsonKey(name: 'korean_name') required String koreanName,
    @JsonKey(name: 'english_name') required String englishName,
    required String market,
    required String type,
  }) = _MarketEntity;
}
