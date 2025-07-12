import 'package:jusicool_ios/data/holding/dto/remote/response/my_holding_response_dto.dart';
import 'package:jusicool_ios/domain/holding/entities/my_holding_entity.dart';

class MyHoldingResponseMapper {
  static MyHoldingResponseDto toDto(MyHoldingEntity entity) =>
      MyHoldingResponseDto(
        id: entity.id, 
        market: entity.market.map((e) => MyMarketDto(
          id: e.id, 
          koreanName: e.koreanName, 
          englishName: e.englishName, 
          market: e.market, 
          type: e.type,
        )),
        quantity: entity.quantity, 
        price: entity.price,
      );
  static MyHoldingEntity toEntity(MyHoldingResponseDto dto) =>
    MyHoldingEntity(
      id: dto.id, 
      market: dto.market.map((e) => MarketEntity(
        id: e.id, 
        koreanName: e.koreanName, 
        englishName: e.englishName, 
        market: e.market, 
        type: e.type,
      )), 
      quantity: dto.quantity, 
      price: dto.price,
    );
}