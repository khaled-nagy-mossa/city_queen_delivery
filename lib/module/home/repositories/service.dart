import 'dart:developer';

import '../model/home.dart';
import '../model/order_label.dart';

import 'repo.dart';

abstract class HomeViewService {
  const HomeViewService();

  static Future homePage() async {
    try {
      final res = await HomeViewRepo.homePage();

      if (res.hasError) throw res.msg;

      return HomeViewModel.fromMap(
        res.json['result']['data'][0] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in HomeViewService.homePage: $e');
      return e.toString();
    }
  }

  static int maxOrdersCountIn(List<OrderLabel> orders) {
    try {
      if (orders == null || orders.isEmpty) return 0;

      var maxCount = orders.first.ordersCount;

      for (final order in orders) {
        if (maxCount < order.ordersCount) maxCount = order.ordersCount;
      }

      return maxCount;
    } catch (e) {
      log('Exception in HomeViewService.maxOrdersCountIn: $e');
      return orders.first.ordersCount;
    }
  }
}
