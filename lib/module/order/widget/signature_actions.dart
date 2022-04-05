import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:signature/signature.dart';

import '../../../common/const/app_data.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/elevated_button_extension.dart';

class SignatureActions extends StatelessWidget {
  final SignatureController controller;
  final void Function(Uint8List uint8list) onSubmit;
  final VoidCallback onClear;

  const SignatureActions({
    @required this.controller,
    @required this.onSubmit,
    @required this.onClear,
    Key key,
  })  : assert(controller != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _clearFiltersBtn(context),
          const SizedBox(width: 10.0),
          _submitButton(context),
        ],
      ),
    );
  }

  Widget _clearFiltersBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: onClear,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.clear, color: AppData.mainColor),
          Text('Clear Filters'.tr),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () async {
          if (controller.isNotEmpty) {
            final uint8list = await controller.toPngBytes();
            if (uint8list != null) {
              onSubmit(uint8list);
            }
          } else {
            AppSnackBar.error(context, 'You must write your signature'.tr);
          }
        },
        style: ElevatedButton.styleFrom(),
        child: Text(
          'Submit'.tr,
          style: TextStyle(color: Colors.white),
        ),
      ).toGradient(context),
    );
  }
}
