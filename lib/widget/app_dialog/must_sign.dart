import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../module/auth/view/registration.dart';

class MustSignDialog extends StatelessWidget {
  const MustSignDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Access Denied!'.tr,
      ),
      content: Text('You must login before do that'.tr),
      actions: [
        TextButton(
          onPressed: () async {
            await AppRoutes.pop(context);
            await AppRoutes.push(context, const RegistrationView());
          },
          child: Text(
            'Login'.tr,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel'.tr,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
