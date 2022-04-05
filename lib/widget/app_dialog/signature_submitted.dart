import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OrderSubmittedDialog extends StatelessWidget {
  const OrderSubmittedDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Congratulations'.tr),
      content: Text('Your order has been sent successfully'.tr),
      actions: [
        TextButton(
          onPressed: () {
            AppRoutes.pop(context);
          },
          child: Text('Ok'.tr),
        ),
      ],
    );
  }
}
