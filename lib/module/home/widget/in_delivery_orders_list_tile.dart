import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

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
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(Assets.images.delivery, color: Colors.white),
      ),
      title: Text(
        'IN_DELIVERY_ORDERS'.tr,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Row(
        children: [
          Text(
            '$ordersCount ',
            style: const TextStyle(color: AppData.secondaryColor),
          ),
          Text(
            'ORDERS'.tr,
            style: const TextStyle(color: AppData.secondaryColor),
          ),
        ],
      ),
      trailing: TextButton(
        onPressed: () {
          AppRoutes.push(context, const MyOrdersView());
        },
        child: Text(
          'SEE ALL'.tr,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
