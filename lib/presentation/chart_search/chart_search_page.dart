import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/chart_search/recently_search.dart';
import 'package:jusicool_ios/presentation/chart_search/popular_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jusicool_ios/presentation/chart_search/recently_search_provider.dart';

class ChartSearchPage extends ConsumerWidget {
  ChartSearchPage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlySearchList = ref.watch(recentlySearchProvider);
    return Scaffold(
      backgroundColor: JusicoolColor.white,
      body: SafeArea(
        top: true,
        minimum: EdgeInsets.only(top: 52.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SizedBox(
                height: 58.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 17.h, bottom: 17.h),
                      child: JusicoolIcon.backArrow(
                        color: Colors.black,
                        width: 24.w,
                        height: 24.h,
                        onTap: () => context.pop(),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (value) {
                          if (value.trim().isEmpty) return;
                          ref.read(recentlySearchProvider.notifier).add(value);
                          _searchController.clear();
                        },
                        style: JusicoolTypography.bodySmall.copyWith(
                          height: 26 / 16,
                          color: JusicoolColor.gray600,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "'AMD'를 검색해보세요",
                          hintStyle: JusicoolTypography.bodySmall.copyWith(
                            height: 26 / 16,
                            color: JusicoolColor.gray400,
                          ),
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            if (recentlySearchList.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SizedBox(
                  height: 32.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentlySearchList.length,
                    separatorBuilder: (context, index) => SizedBox(width: 8.w),
                    itemBuilder: (context, index) {
                      final item = recentlySearchList[index];
                      return RecentlySearchBlock(
                        chartName: item['chartName'] as String,
                        changeValue: item['changeValue'] as int,
                        changePercent: item['changePercent'] as double,
                        onRemove: () {
                          ref
                              .read(recentlySearchProvider.notifier)
                              .removeAt(index);
                        },
                      );
                    },
                  ),
                ),
              ),
            if (recentlySearchList.isNotEmpty) SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                '인기 검색어',
                style: JusicoolTypography.bodyMedium.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 11.h),
            Column(
              children: List.generate(5, (index) {
                final rank = index + 1;
                final name =
                    ['두산로보틱스', '삼성전자', 'LG에너지솔루션', '현대차', '카카오'][index % 5];
                final change = [12.5, -3.2, 0.0, 7.1, -0.8][index % 5];
                return Padding(
                  padding: EdgeInsets.only(bottom: 11.h),
                  child: PopularSearchItem(
                    rank: rank,
                    name: name,
                    changePercent: change,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}