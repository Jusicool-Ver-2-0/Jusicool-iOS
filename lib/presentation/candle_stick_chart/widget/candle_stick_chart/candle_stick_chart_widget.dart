import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' hide TextDirection;
import '../../controller/candle_stick_chart_widget_controller.dart';
import '../../state/candle_stick_chart_widget_state.dart';
import 'candle_stick_item.dart';

class CandleStickChartWidget extends StatefulWidget {
  const CandleStickChartWidget({super.key, required this.data});

  final List<StockCandleStickChartWidgetData> data;

  @override
  State<CandleStickChartWidget> createState() => _CandleStickChartWidgetState();
}

class _CandleStickChartWidgetState extends State<CandleStickChartWidget> {
  bool _isInit = false;

  double get candleStickChartHeight => 270.h;
  late final CandleStickChartWidgetController state;
  static final NumberFormat coast = NumberFormat('###,###,###,###');

  @override
  void initState() {
    super.initState();
    state = CandleStickChartWidgetController();
    state.widget = widget;
    Get.put(state);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.scrollView.hasClients) {
        state.scrollView.jumpTo(1); // Trigger layout
        _isInit = true;
      }
    });
  }

  @override
  void didUpdateWidget(covariant CandleStickChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      final isDataLengthIncreased = widget.data.length > oldWidget.data.length;

      if (_isInit && isDataLengthIncreased) {
        // 데이터가 증가했을 때만 스크롤
        WidgetsBinding.instance.addPostFrameCallback(
              (_) async => state.scrollView.animateTo(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          ),
        );
      }

      state.data.assignAll(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        state.maxWidth = constraints.maxWidth;
        return GestureDetector(
          onScaleStart: state.onScaleStart,
          onScaleUpdate: state.onScaleUpdate,
          child: NotificationListener(
            onNotification: (event) {
              if (event is ScrollUpdateNotification) {
                state.updateOffset(event.metrics.pixels);
              }
              return true;
            },
            child: Obx(() {
              final itemCount = state.data.length;
              final itemExtent = state.itemWidth.value;
              return CustomScrollView(
                controller: state.scrollView,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                reverse: true,
                slivers: [
                  SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                      (context, dataIndex) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.5),
                          child: CandleStickItem(index: dataIndex),
                        );
                      },
                      childCount: itemCount,
                      addAutomaticKeepAlives: true,
                    ),
                    itemExtent: itemExtent,
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
