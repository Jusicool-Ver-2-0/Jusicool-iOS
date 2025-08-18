import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jusicool_ios/domain/candle_stick_chart/usecase/candle_stick_chart_usecase.dart';
import 'package:jusicool_ios/presentation/candle_stick_chart/state/candle_stick_chart_state.dart';
import '../../../core/config/di/dependencies.dart';
import '../mapper/candle_stick_chart_mapper.dart';

final candleStickChartControllerProvider =
    StateNotifierProvider<CandleStickChartController, CandleStickChartState>(
      (ref) => CandleStickChartController(di.get<CandleStickChartUseCase>()),
    );

class CandleStickChartController extends StateNotifier<CandleStickChartState> {
  final CandleStickChartUseCase _candleStickChartUseCase;
  Timer? _timer;

  CandleStickChartController(this._candleStickChartUseCase)
    : super(CandleStickChartState()) {
    updateState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (_) => updateState());
  }

  void updateState() async {
    try {
      final fetched = await _candleStickChartUseCase.fetchCandlestickChartData(
        market: "KRW-BTC",
        count: 100,
      );

      final newData = CandleStickChartMapper.toData(fetched);
      state = state.copyWith(
        data: newData,
        stockPrice: newData.isNotEmpty ? newData[0].tradePrice : 0.0,
        stockName: "비트코인",
      );
    } catch (e) {
      print("Error fetching candlestick chart data: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
