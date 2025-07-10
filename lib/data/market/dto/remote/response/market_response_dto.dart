import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_response_dto.freezed.dart';
part 'market_response_dto.g.dart';

@freezed
abstract class MarketResponseDto with _$MarketResponseDto {
  const factory MarketResponseDto({
    required int id,
    @JsonKey(name: 'korean_name') required String koreanName,
    @JsonKey(name: 'english_name') required String englishName,
    required String market,
    @JsonKey(name: 'market_type') required String marketType,
  }) = _MarketResponseDto;

  factory MarketResponseDto.fromJson(Map<String, dynamic> json) => _$MarketResponseDtoFromJson(json);
} 