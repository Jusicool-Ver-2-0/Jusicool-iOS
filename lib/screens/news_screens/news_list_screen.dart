import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/ui/widgets/card/news_card.dart'; // NewsCard 클래스 import
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';

class NewsListPage extends StatelessWidget {
  final List<Map<String, String>> newsItems = List.generate(
    10,
    (index) => {
      "title": "애플, 사상 최고가... 올해 세계경제 2.6% 성장 전망",
      "subtitle": "이데일리",
      "imageUrl": "https://picsum.photos/200/200?random=$index",
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text("뉴스", style: AppTypography.subTitle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.separated(
          itemCount: newsItems.length,
          separatorBuilder: (_, __) => SizedBox(height: 20.h),
          itemBuilder: (context, index) {
            final item = newsItems[index];
            return NewsCard(
              title: item["title"]!,
              subtitle: item["subtitle"]!,
              imageUrl: item["imageUrl"]!,
            );
          },
        ),
      ),
    );
  }
}
