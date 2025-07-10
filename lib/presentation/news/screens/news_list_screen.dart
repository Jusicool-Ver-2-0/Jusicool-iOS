import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:url_launcher/url_launcher.dart';

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

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final ScrollController _scrollController = ScrollController();
  List<NewsItem> newsItems = [];

  @override
  void initState() {
    super.initState();
    _loadNewsItems();
  }

  Future<void> _loadNewsItems() async {
    try {
      final jsonString = await DefaultAssetBundle.of(
        context,
      ).loadString('assets/data/news.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      final items = jsonData.map((e) => NewsItem.fromJson(e)).toList();

      setState(() => newsItems = items);
    } catch (e) {
      debugPrint('뉴스 로드 실패: $e');
      _showErrorSnackBar('뉴스 데이터를 불러올 수 없습니다.');
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorSnackBar('링크를 열 수 없습니다.');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JusicoolColor.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 56.h),
        child:
            newsItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                  controller: _scrollController,
                  itemCount: newsItems.length,
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  itemBuilder: (context, index) {
                    final item = newsItems[index];
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
    );
  }
}
