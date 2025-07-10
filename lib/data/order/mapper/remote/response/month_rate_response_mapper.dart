import 'package:jusicool_ios/data/order/dto/remote/response/month_rate_response_dto.dart';
import 'package:jusicool_ios/domain/order/entities/month_rate_entity.dart';
class MonthRateResponseMapper {
  static MonthRateResponseDto toDto(MonthRateEntity entity) =>
      MonthRateResponseDto(
        monthlyRate: entity.monthlyRate,
        markets: entity.markets.map((e) => MarketDto(
          market: e.market,
          koreanName: e.koreanName,
          rate: e.rate,
          proceed: e.proceed,
          day: e.day,
        )).toList(),
      );
  static MonthRateEntity toEntity(MonthRateResponseDto dto) =>
      MonthRateEntity(
        monthlyRate: dto.monthlyRate,
        markets: dto.markets.map((e) => MarketEntity(
          market: e.market,
          koreanName: e.koreanName,
          rate: e.rate,
          proceed: e.proceed,
          day: e.day,
        )).toList(),
      );
}