import 'package:jusicool_ios/data/market/dto/remote/response/market_response_dto.dart';
import 'package:jusicool_ios/domain/market/entities/market_entity.dart';
import 'package:jusicool_ios/domain/enum/share/market/market_type.dart';

class MarketResponseMapper {
  static MarketEntity toEntity(MarketResponseDto dto) => MarketEntity(
    id: dto.id,
    koreanName: dto.koreanName,
    englishName: dto.englishName,
    market: dto.market,
    marketType: _marketTypeFromString(dto.marketType),
  );
}

MarketType _marketTypeFromString(String value) {
  switch (value) {
    case 'CRYPTO':
      return MarketType.crypto();
    case 'STOCK':
      return MarketType.stock();
    default:
      throw Exception('Unknown MarketType: $value');
  }
} 