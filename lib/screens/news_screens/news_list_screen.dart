import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/src/ui/widgets/card/news_card.dart';
import 'package:jusicool_design_system/src/core/theme/texts/typography.dart';
import 'package:jusicool_design_system/src/core/theme/colors/color_palette.dart';
import 'package:url_launcher/url_launcher.dart';

/// 뉴스 아이템 데이터 모델
class NewsItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String linkUrl;

  const NewsItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.linkUrl,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String,
      linkUrl: json['linkUrl'] as String,
    );
  }
}

/// 뉴스 리스트 화면
class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  List<NewsItem> _newsItems = [];
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);

    // 안전하게 JSON 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNewsItems();
    });
  }

  Future<void> _loadNewsItems() async {
    try {
      final String jsonString = await DefaultAssetBundle.of(
        context,
      ).loadString('assets/data/news.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      setState(() {
        _newsItems = jsonData.map((item) => NewsItem.fromJson(item)).toList();
      });
    } catch (e) {
      debugPrint('뉴스 로드 실패: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('뉴스 데이터를 불러올 수 없습니다.')));
    }
  }

  void _handleScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  Color _getAppBarColor() {
    return _scrollOffset < 20 ? Colors.transparent : AppColor.white;
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('링크를 열 수 없습니다.')));
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double appBarHeight = kToolbarHeight + statusBarHeight;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          // 뉴스 리스트
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child:
                _newsItems.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: appBarHeight + 24.h),
                      itemCount: _newsItems.length,
                      separatorBuilder: (_, __) => SizedBox(height: 20.h),
                      itemBuilder: (context, index) {
                        final item = _newsItems[index];
                        return GestureDetector(
                          onTap: () => _launchUrl(item.linkUrl),
                          child: NewsCard(
                            key: ValueKey('${item.title}_$index'),
                            title: item.title,
                            subtitle: item.subtitle,
                            imageUrl: item.imageUrl,
                          ),
                        );
                      },
                    ),
          ),
          // 커스텀 AppBar
          Container(
            height: appBarHeight,
            padding: EdgeInsets.only(top: statusBarHeight),
            color: _getAppBarColor(),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                Text(
                  "뉴스",
                  style: AppTypography.subTitle.copyWith(color: Colors.black),
                ),
                const Spacer(),
                SizedBox(width: 48.w), // 아이콘 영역 여백
              ],
            ),
          ),
        ],
      ),
    );
  }
}
