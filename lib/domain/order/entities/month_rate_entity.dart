import 'package:freezed_annotation/freezed_annotation.dart';

part 'month_rate_entity.freezed.dart';

@freezed
abstract class MonthRateEntity with _$MonthRateEntity {
  factory MonthRateEntity({
    required double monthlyRate,
    required List<MarketEntity> markets,
  }) = _MonthRateEntity;
}

@freezed
abstract class MarketEntity with _$MarketEntity {
  factory MarketEntity({
    required String market,
    required String koreanName,
    required double rate,
    required int proceed,
    required DateTime day,
  }) = _MarketEntity;
} 