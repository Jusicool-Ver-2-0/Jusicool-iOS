import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_request_dto.freezed.dart';
part 'market_request_dto.g.dart';

@freezed
abstract class MarketRequestDto with _$MarketRequestDto {
  const factory MarketRequestDto({
    required String type,
  }) = _MarketRequestDto;

  factory MarketRequestDto.fromJson(Map<String, dynamic> json) => _$MarketRequestDtoFromJson(json);
} 