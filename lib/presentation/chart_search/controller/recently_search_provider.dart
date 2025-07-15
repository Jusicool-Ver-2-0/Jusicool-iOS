import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentlySearchProvider =
    StateNotifierProvider<RecentlySearchNotifier, List<Map<String, dynamic>>>(
      (ref) => RecentlySearchNotifier(),
    );

class RecentlySearchNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  RecentlySearchNotifier()
    : super([
        {'chartName': '애플', 'changeValue': 111186, 'changePercent': 7.9},
        {'chartName': '테슬라', 'changeValue': -123456, 'changePercent': -3.2},
        {'chartName': '삼성', 'changeValue': -123416, 'changePercent': -3.2},
      ]);

  void add(String chartName) {
    state = [
      {'chartName': chartName, 'changeValue': 0, 'changePercent': 0.0},
      ...state.where((item) => item['chartName'] != chartName),
    ];
  }

  void removeAt(int index) {
    final newList = [...state];
    newList.removeAt(index);
    state = newList;
  }
}
