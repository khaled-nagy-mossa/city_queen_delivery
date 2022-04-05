import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class LocationPermissionLocation extends StatelessWidget {
  final VoidCallback tryAgain;

  const LocationPermissionLocation({this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('application require permission.'.tr),
      content: const Text(
        'we are sorry , application require permission to start live tracking and get orders',
      ),
      actions: [
        TextButton(
          onPressed: tryAgain,
          child: Text('Try Again'.tr),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'.tr),
        ),
      ],
    );
  }
}
