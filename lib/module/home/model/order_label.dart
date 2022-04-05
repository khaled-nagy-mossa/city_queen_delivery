import 'dart:convert';
import 'dart:developer';

class OrderLabel {
  const OrderLabel({
    this.label,
    this.ordersCount,
  });

  final DateTime label;
  final int ordersCount;

  OrderLabel copyWith({
    DateTime label,
    int ordersCount,
  }) {
    try {
      return OrderLabel(
        label: label ?? this.label,
        ordersCount: ordersCount ?? this.ordersCount,
      );
    } catch (e) {
      log('Exception in OrderLabel.copyWith : $e');
      return this;
    }
  }

  factory OrderLabel.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const OrderLabel();

      return OrderLabel.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderLabel.fromJson : $e');
      return const OrderLabel();
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderLabel.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const OrderLabel();
      return OrderLabel(
        label: DateTime.parse(json['label'] as String),
        ordersCount: json['orders_count'] as int,
      );
    } catch (e) {
      log('Exception in OrderLabel.fromMap : $e');
      return const OrderLabel();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'label': label == null
            ? null
            : "${label.year.toString().padLeft(4, '0')}-${label.month.toString().padLeft(2, '0')}-${label.day.toString().padLeft(2, '0')}",
        'orders_count': ordersCount,
      };
    } catch (e) {
      log('Exception in OrderLabel.toMap : $e');
      return <String, dynamic>{};
    }
  }
}
