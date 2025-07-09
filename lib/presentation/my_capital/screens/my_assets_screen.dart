import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';
import 'package:jusicool_ios/presentation/my_capital/widgets/my_asset_tile.dart';
import '../../../domain/my_capital/entities/my_assets.dart';

class MyAssetsScreen extends StatefulWidget {
  const MyAssetsScreen({super.key});

  @override
  State<MyAssetsScreen> createState() => _MyAssetsScreenState();
}

class _MyAssetsScreenState extends State<MyAssetsScreen> {
  late Future<MyAssetsData> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadAssetsData();
  }

  Future<MyAssetsData> _loadAssetsData() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/my_assets.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return MyAssetsData.fromJson(jsonMap);
  }

  Color hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('ff'); // 투명도(100%)
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');

    return Scaffold(
      backgroundColor: JusicoolColor.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: JusicoolColor.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: 24.sp),
          icon: const Icon(Icons.arrow_back, color: JusicoolColor.black),
          onPressed: () => Navigator.of(context).pop,
        ),
        title: Text('내 자산', style: JusicoolTypography.subTitle),
      ),
      body: SafeArea(
        child: FutureBuilder<MyAssetsData>(
          future: _futureData,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(child: Text('에러: ${snap.error}'));
            }
            final data = snap.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    "${formatter.format(data.totalAsset)}원",
                    style: JusicoolTypography.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '지난 달 보다 ',
                          style: JusicoolTypography.bodySmall,
                        ),
                        TextSpan(
                          text: '${formatter.format(data.change)}원 ',
                          style: JusicoolTypography.bodySmall.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: '늘었어요',
                          style: JusicoolTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "주문 가능 금액",
                    style: JusicoolTypography.bodyMedium.copyWith(
                      color: JusicoolColor.gray600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${formatter.format(data.availableAmount)}원",
                    style: JusicoolTypography.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "투자 금액",
                    style: JusicoolTypography.bodyMedium.copyWith(
                      color: JusicoolColor.gray600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${formatter.format(data.investmentAmount)}원",
                    style: JusicoolTypography.titleSmall,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 80,
                        sections:
                            data.sections
                                .map(
                                  (s) => PieChartSectionData(
                                    color: hexToColor(s.colorHex),
                                    value: s.percentage,
                                    title: '',
                                    radius: 45,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.sections.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      final s = data.sections[index];
                      return MyAssetTile(
                        stockName: s.name,
                        stockPrice: "${formatter.format(s.price)}원",
                        percentage: "${s.percentage.toStringAsFixed(1)}%",
                        iconColor: hexToColor(s.colorHex),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
