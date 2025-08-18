import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_request_dto.g.dart';

part 'exchange_request_dto.freezed.dart';

@freezed
abstract class ExchangeRequestDto with _$ExchangeRequestDto {
  factory ExchangeRequestDto({
    required int amount
  }) = _ExchangeRequestDto;

  factory ExchangeRequestDto.fromJson(Map<String,dynamic> json) =>
      _$ExchangeRequestDtoFromJson(json);
} 