import 'package:freezed_annotation/freezed_annotation.dart';

part 'month_rate_response_dto.g.dart';
part 'month_rate_response_dto.freezed.dart';

@freezed
abstract class MonthRateResponseDto with _$MonthRateResponseDto {
  factory MonthRateResponseDto({
    @JsonKey(name: 'monthly_rate') required double monthlyRate,
    required List<MarketDto> markets,
  }) = _MonthRateResponseDto;

  factory MonthRateResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MonthRateResponseDtoFromJson(json);
}

@freezed
abstract class MarketDto with _$MarketDto {
  factory MarketDto({
    required String market,
    @JsonKey(name: 'korean_name') required String koreanName,
    required double rate,
    required int proceed,
    required DateTime day,
  }) = _Market;

  factory MarketDto.fromJson(Map<String, dynamic> json) =>
      _$MarketFromJson(json);
}