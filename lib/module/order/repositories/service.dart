import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../model/order/order.dart';
import '../../../model/order/order_list.dart';
import '../controller/const.dart';
import '../model/order_type_tab_model.dart';
import '../model/orders_param.dart';
import 'repo.dart';

abstract class OrderService {
  const OrderService();

  static Future orders({@required OrdersListParam ordersParam}) async {
    assert(ordersParam != null);
    try {
      final res = await OrderRepo.orders(param: ordersParam);

      if (res.hasError) throw res.msg;

      return OrderList.fromMap(res.json['result'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in currentOrders in OrderService : $e');
      return e.toString();
    }
  }

  static Future orderById(int id) async {
    assert(id != null);

    try {
      final res = await OrderRepo.getOrder(orderId: id);

      if (res.hasError) throw res.msg;

      return Order.fromMap(res.json['result']['data'] as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderService.orderById : $e');
      return e.toString();
    }
  }

  static Future updateOrderAddress({
    @required int orderId,
    @required int addressId,
  }) async {
    assert(orderId != null);
    assert(addressId != null);

    try {
      final res = await OrderRepo.updateOrderAddress(
        orderId: orderId,
        addressId: addressId,
      );

      if (res.hasError) return res.msg;

      return Order.fromMap(res.json['result']['data'] as Map<String, dynamic>);
    } catch (e) {
      return e.toString();
    }
  }

  static Future signOrder({
    @required int orderId,
    @required String imageEncoded,
  }) async {
    assert(orderId != null);
    assert(imageEncoded != null);

    try {
      final res = await OrderRepo.signOrder(
        orderId: orderId,
        imageEncoded: imageEncoded,
      );

      if (res.hasError) return res.msg;

      return Order.fromMap(res.json['result']['data'] as Map<String, dynamic>);
    } catch (e) {
      return e.toString();
    }
  }

  static Future updateOrderStatusToDelivered({
    @required int orderId,
    @required double totalPrice,
  }) async {
    assert(orderId != null);
    assert(totalPrice != null);
    try {
      final res = await OrderRepo.updateOrderStatusToDelivered(
        orderId: orderId,
        totalPrice: totalPrice,
      );

      if (res.hasError) return res.msg;

      return Order.fromMap(res.json['result']['data'] as Map<String, dynamic>);
    } catch (e) {
      return e.toString();
    }
  }

  static OrderTypeTapModel getOrderTap(String parameter) {
    OrderTypeTapModel t;
    for (final tab in orderTypeTabs) {
      if (tab.orderTypeParameter == parameter) {
        t = tab;
        break;
      }
    }
    return t;
  }
}
