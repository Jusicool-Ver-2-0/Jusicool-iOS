import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_search_request_dto.freezed.dart';
part 'market_search_request_dto.g.dart';

@freezed
abstract class MarketSearchRequestDto with _$MarketSearchRequestDto {
  const factory MarketSearchRequestDto({
    required String query,
  }) = _MarketSearchRequestDto;

  factory MarketSearchRequestDto.fromJson(Map<String, dynamic> json) => _$MarketSearchRequestDtoFromJson(json);
} 