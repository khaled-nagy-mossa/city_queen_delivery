import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../model/order/order.dart';
import '../controller/const.dart';

class OrderTypeWidget extends StatelessWidget {
  final Order order;

  //will remove this argument when back end return this type
  final OrderType type;

  const OrderTypeWidget({@required this.order, @required this.type});

  static const _constraints = BoxConstraints(maxHeight: 25.0);
  static final _borderRadius = BorderRadius.circular(15.0);

  @override
  Widget build(BuildContext context) {
    if (order == null || type == null) return const SizedBox();
    try {
      switch (type) {
        case OrderType.delivered:
          return _doneShape();
          break;
        case OrderType.inDelivery:
          return _inDeliveryShape();
          break;
        case OrderType.all:
          return _waitingShape();
          break;
        default:
          return const SizedBox();
          break;
      }
    } catch (e) {
      log('Exception in OrderTypeWidget : $e'.tr);
      return const SizedBox();
    }
  }

  Widget _title(String str) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      child: Text(
        str,
        style: const TextStyle(color: Colors.white, fontSize: 12.0),
      ),
    );
  }

  Widget _doneShape() {
    return Container(
      constraints: _constraints,
      decoration: BoxDecoration(
        color: const Color(0xFF84CB27),
        borderRadius: _borderRadius,
      ),
      child: _title('Done'.tr),
    );
  }

  Widget _inDeliveryShape() {
    return Container(
      constraints: _constraints,
      decoration: BoxDecoration(
        color: const Color(0xFF3E3E3E),
        borderRadius: _borderRadius,
      ),
      child: _title('In Delivery'.tr),
    );
  }

  Widget _waitingShape() {
    return Container(
      constraints: _constraints,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: _borderRadius,
      ),
      child: _title('Waiting'.tr),
    );
  }
}
