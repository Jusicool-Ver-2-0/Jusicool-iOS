import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/chart_detail/chart_list_card.dart';
import 'package:jusicool_ios/presentation/chart_search/screens/recently_search.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_ios/core/config/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jusicool_ios/presentation/chart_search/controller/recently_search_provider.dart';

class ChartListPage extends ConsumerStatefulWidget {
  const ChartListPage({super.key});
  @override
  ConsumerState<ChartListPage> createState() => _ChartListPageState();
}

class _ChartListPageState extends ConsumerState<ChartListPage> {
  List<Map<String, dynamic>> chartList = [
    {
      'imageUrl':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'chartName': '애플',
      'price': 11111131,
      'changeValue': 111186,
      'changePercent': 7.9,
    },
    {
      'imageUrl':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'chartName': '테슬라',
      'price': 9876543,
      'changeValue': -123456,
      'changePercent': -3.2,
    },
    {
      'imageUrl':
          'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo-500x281.png',
      'chartName': '삼성',
      'price': 9876523,
      'changeValue': -123416,
      'changePercent': -3.2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final recentlySearchList = ref.watch(recentlySearchProvider);
    return ColoredBox(
      color: JusicoolColor.white,
      child: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 52.h),
        child: Scaffold(
          backgroundColor: JusicoolColor.white,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  top: 20.h,
                  bottom: 20.h,
                  right: 24.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    JusicoolImage.logo(width: 116.w, height: 17.h),
                    GestureDetector(
                      onTap:
                          () =>
                              GoRouter.of(context).push(RoutePaths.chartSearch),
                      child: JusicoolIcon.search(width: 24.w, height: 24.h),
                    ),
                  ],
                ),
              ),
              if (recentlySearchList.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: SizedBox(
                    height: 32.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 16.w),
                      itemCount: recentlySearchList.length,
                      itemBuilder: (context, index) {
                        final item = recentlySearchList[index];
                        final chart = chartList.firstWhere(
                          (c) => c['chartName'] == item['chartName'],
                          orElse:
                              () => {'changeValue': 0, 'changePercent': 0.0},
                        );
                        return RecentlySearchBlock(
                          chartName: item['chartName'] as String,
                          changeValue: chart['changeValue'] as int,
                          changePercent: chart['changePercent'] as double,
                          onRemove: () {
                            ref
                                .read(recentlySearchProvider.notifier)
                                .removeAt(index);
                          },
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(width: 8.w),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: chartList.length,
                    itemBuilder: (context, index) {
                      final chart = chartList[index];
                      return ChartListCard(
                        imageUrl: chart['imageUrl'],
                        chartName: chart['chartName'],
                        price: chart['price'],
                        changeValue: chart['changeValue'],
                        changePercent: chart['changePercent'],
                      );
                    },
                    separatorBuilder:
                        (context, index) =>
                            Padding(padding: EdgeInsets.only(top: 16.h)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
