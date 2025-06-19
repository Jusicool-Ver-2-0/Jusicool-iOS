class MyAssetsData {
  final int totalAsset;
  final int change;
  final int availableAmount;
  final int investmentAmount;
  final List<MyAssetSection> sections;

  MyAssetsData({
    required this.totalAsset,
    required this.change,
    required this.availableAmount,
    required this.investmentAmount,
    required this.sections,
  });

  factory MyAssetsData.fromJson(Map<String, dynamic> json) {
    return MyAssetsData(
      totalAsset: json['totalAsset'],
      change: json['change'],
      availableAmount: json['availableAmount'],
      investmentAmount: json['investmentAmount'],
      sections:
          (json['sections'] as List)
              .map((e) => MyAssetSection.fromJson(e))
              .toList(),
    );
  }
}

class MyAssetSection {
  final String name;
  final int price;
  final double percentage;
  final String colorHex; // hex 문자열로 받아서 화면에서 처리

  MyAssetSection({
    required this.name,
    required this.price,
    required this.percentage,
    required this.colorHex,
  });

  factory MyAssetSection.fromJson(Map<String, dynamic> json) {
    return MyAssetSection(
      name: json['name'],
      price: json['price'],
      percentage: json['percentage'].toDouble(),
      colorHex: json['color'],
    );
  }
}
