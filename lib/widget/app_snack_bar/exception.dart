import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'app_snack_bar.dart';

abstract class ExceptionsSnackBars {
  const ExceptionsSnackBars();

  static SnackBar normalException({@required String e}) {
    return SnackBar(content: Text(e));
  }

  static SnackBar unknownException() {
    return SnackBar(content: Text('Unknown Exception'.tr));
  }

  static SnackBar networkException() {
    return SnackBar(content: Text('Network Exception'.tr));
  }

  static SnackBar errorSnackBar({
    @required BuildContext context,
    @required String e,
  }) {
    return SnackBar(
      content: Text(e),
      action: SnackBarAction(
        label: 'Ok'.tr,
        onPressed: () {
          AppSnackBar.hideSnackBar(context);
        },
      ),
    );
  }
}
