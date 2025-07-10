import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_holding_response_dto.g.dart';
part 'my_holding_response_dto.freezed.dart';

@freezed
abstract class MyHoldingResponseDto with _$MyHoldingResponseDto {
  factory MyHoldingResponseDto({
    required int id,
    required MyMarketDto market,
    required int quantity,
    required int price,
  }) = _MyHoldingResponseDto;

  factory MyHoldingResponseDto.fromJson(Map<String,dynamic> json) =>
      _$MyHoldingResponseDtoFromJson(json);
}

@freezed
abstract class MyMarketDto with _$MyMarketDto {
  factory MyMarketDto({
    required int id,
    @JsonKey(name: 'korean_name') required String koreanName,
    @JsonKey(name: 'english_name') required String englishName,
    required String market,
    required String type,
  }) = _MyMarketDto;

  factory MyMarketDto.fromJson(Map<String,dynamic> json) =>
      _$MyMarketDtoFromJson(json);
}