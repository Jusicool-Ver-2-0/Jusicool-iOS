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
    if (hex.length == 7) buffer.write('ff');
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
          onPressed: () => Navigator.of(context).pop(),
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
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 56.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24.h,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        "${formatter.format(data.totalAsset)}원",
                        style: JusicoolTypography.titleMedium,
                      ),
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
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2.h,
                    children: [
                      Text(
                        "주문 가능 금액",
                        style: JusicoolTypography.bodyMedium.copyWith(
                          color: JusicoolColor.gray600,
                        ),
                      ),
                      Text(
                        "${formatter.format(data.availableAmount)}원",
                        style: JusicoolTypography.titleSmall,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2.h,
                    children: [
                      Text(
                        "투자 금액",
                        style: JusicoolTypography.bodyMedium.copyWith(
                          color: JusicoolColor.gray600,
                        ),
                      ),
                      Text(
                        "${formatter.format(data.investmentAmount)}원",
                        style: JusicoolTypography.titleSmall,
                      ),
                    ],
                  ),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 70.h,
                        sections:
                            data.sections
                                .map(
                                  (s) => PieChartSectionData(
                                    color: hexToColor(s.colorHex),
                                    value: s.percentage,
                                    title: '',
                                    radius: 40.h,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                  Column(
                    spacing: 16.h,
                    children:
                        data.sections.map((s) {
                          return MyAssetTile(
                            stockName: s.name,
                            stockPrice: "${formatter.format(s.price)}원",
                            percentage: "${s.percentage.toStringAsFixed(1)}%",
                            iconColor: hexToColor(s.colorHex),
                          );
                        }).toList(),
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
