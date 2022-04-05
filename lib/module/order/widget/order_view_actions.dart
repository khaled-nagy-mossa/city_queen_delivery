import 'package:app_launcher/app_launcher.dart';
import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../model/order/order.dart';
import '../controller/const.dart';
import '../view/order_submission_screens/payment.dart';
import 'finish_btn.dart';
import 'map_button.dart';

class OrderViewActions extends StatelessWidget {
  final Order order;
  final OrderType type;

  const OrderViewActions({@required this.order, @required this.type, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case OrderType.inDelivery:
        return Column(
          children: [
            MapButton(onTap: () {
              AppLauncher.launchToMap(
                lat: order?.shippingAddress?.lat?.toString(),
                lon: order?.shippingAddress?.lat?.toString(),
              );
            }),
            const SizedBox(height: 10.0),
            FinishButton(
              onTap: () {
                AppRoutes.push(context, OrderPaymentView(order: order));
              },
            ),
          ],
        );
        break;

      default:
        return const SizedBox();
        break;
    }
  }
}
