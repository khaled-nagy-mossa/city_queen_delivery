import 'dart:convert';
import 'dart:developer';

import '../../../model/order/order.dart';
import 'order_label.dart';

class HomeViewModel {
  const HomeViewModel({
    this.totalCollected,
    this.totalEarning,
    this.ordersLabel,
    this.inDeliveryOrders,
  });

  final String totalCollected;
  final String totalEarning;
  final List<OrderLabel> ordersLabel;
  final List<Order> inDeliveryOrders;

  HomeViewModel copyWith({
    String totalCollected,
    String totalEarning,
    List<OrderLabel> ordersLabel,
    List<Order> inDeliveryOrders,
  }) {
    try {
      return HomeViewModel(
        totalCollected: totalCollected ?? this.totalCollected,
        totalEarning: totalEarning ?? this.totalEarning,
        ordersLabel: ordersLabel ?? this.ordersLabel,
        inDeliveryOrders: inDeliveryOrders ?? this.inDeliveryOrders,
      );
    } catch (e) {
      log('Exception in HomeModel.copyWith : $e');
      return this;
    }
  }

  factory HomeViewModel.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const HomeViewModel();

      return HomeViewModel.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in HomeModel.fromJson : $e');
      return const HomeViewModel();
    }
  }

  String toJson() => json.encode(toMap());

  factory HomeViewModel.fromMap(Map<String, dynamic> json) {
    try {
      return HomeViewModel(
        totalCollected: json['total_collected'] as String,
        totalEarning: json['total_earning'] as String,
        ordersLabel: List<OrderLabel>.from(
          ((json['counts'] ?? <Map>[]) as List).map<OrderLabel>(
            (dynamic x) => OrderLabel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        inDeliveryOrders: List<Order>.from(
          ((json['in_delivery_orders'] ?? <Map>[]) as List).map<Order>(
            (dynamic x) => Order.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } catch (e) {
      log('Exception in HomeModel.fromMap : $e');
      return const HomeViewModel();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'total_collected': totalCollected,
        'total_earning': totalEarning,
        'counts': ordersLabel == null
            ? null
            : List<dynamic>.from(ordersLabel.map<Map>((x) => x.toMap())),
        'in_delivery_orders': inDeliveryOrders == null
            ? null
            : List<dynamic>.from(inDeliveryOrders.map<Map>((x) => x.toMap())),
      };
    } catch (e) {
      log('Exception in HomeModel.fromMap : $e');
      return <String, dynamic>{};
    }
  }
}
