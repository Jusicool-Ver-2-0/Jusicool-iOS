import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_type.g.dart';
part 'market_type.freezed.dart';

@freezed
abstract class MarketType with _$MarketType {
  const factory MarketType.crypto() = _Crypto;
  const factory MarketType.stock() = _Stock;
  
  factory MarketType.fromJson(Map<String, dynamic> json) =>
      _$MarketTypeFromJson(json);
}