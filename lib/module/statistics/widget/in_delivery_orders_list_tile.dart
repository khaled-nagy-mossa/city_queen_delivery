import 'package:flutter/material.dart';

import '../../../common/const/app_data.dart';
import '../../chat/common/chat_view_imports.dart';
import '../../order/view/my_orders_view.dart';

class InDeliveryOrdersListTile extends StatelessWidget {
  final int ordersCount;

  const InDeliveryOrdersListTile({@required this.ordersCount, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ordersCount == null || ordersCount == 0) return const SizedBox();
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        constraints: const BoxConstraints(maxHeight: 55.0, maxWidth: 55.0),
        decoration: BoxDecoration(
          gradient: AppData.gradient,
          shape: BoxShape.circle,
        ),
      ),
      title: const Text(
        'In Delivery Orders',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        '$ordersCount orders',
        style: const TextStyle(color: AppData.secondaryColor),
      ),
      trailing: TextButton(
        onPressed: () {
          AppRoutes.push(context, const MyOrdersView());
        },
        child: const Text(
          'SEE ALL',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
