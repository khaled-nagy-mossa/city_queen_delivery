import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          Text('Loading'.tr),
          SizedBox(width: 20.0),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
