import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jusicool_ios/presentation/candle_stick_chart/controller/candle_stick_chart_controller.dart';
import '../widget/buy_stock_button_widget.dart';
import '../widget/candle_stick_chart/candle_stick_chart_widget.dart';
import '../widget/candle_stick_chart_scaffold.dart';
import '../widget/stock_community_widget.dart';
import '../widget/stock_introduction_widget.dart';
import '../widget/stock_news_widget.dart';
import '../widget/stock_price_widget.dart';
import '../widget/stock_quote_widget.dart';
import '../widget/stocks_info_tabbar.dart';
import '../widget/stocks_info_tabbar_view.dart';

class CandleStickChartScreen extends ConsumerStatefulWidget {
  const CandleStickChartScreen({super.key});

  @override
  ConsumerState<CandleStickChartScreen> createState() =>
      _CandleStickChartScreenState();
}

class _CandleStickChartScreenState extends ConsumerState<CandleStickChartScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(candleStickChartControllerProvider);
    return CandlestickChartScaffold(
      stockName: state.stockName,
      stockPriceWidget: StockPriceWidget(price: state.stockPrice),
      candlestickChartWidget: CandleStickChartWidget(data: state.data),
      buyStockButtonWidget: BuyStockButtonWidget(),
      stocksInfoTabBar: StocksInfoTabBar(tabController: tabController),
      stocksInfoTabBarView: StocksInfoTabBarView(
        tabController: tabController,
        stockIntroductionWidget: StockIntroductionWidget(),
        stockQuoteWidget: StockQuoteWidget(),
        stockNewsWidget: StockNewsWidget(),
        stockCommunityWidget: StockCommunityWidget(),
      ),
    );
  }
}
