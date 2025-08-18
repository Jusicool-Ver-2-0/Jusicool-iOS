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
