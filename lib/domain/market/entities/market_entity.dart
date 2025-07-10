import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jusicool_ios/domain/enum/share/market/market_type.dart';

part 'market_entity.freezed.dart';

@freezed
abstract class MarketEntity with _$MarketEntity {
  const factory MarketEntity({
    required int id,
    required String koreanName,
    required String englishName,
    required String market,
    required MarketType marketType,
  }) = _MarketEntity;
} 