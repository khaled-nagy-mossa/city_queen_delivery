import 'package:flutter/material.dart';

import 'exception.dart';

abstract class AppSnackBar {
  const AppSnackBar();

  static void _show(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  // Exception Snack Bar #######################################################
  static void exception({
    @required BuildContext context,
    @required String errorMsg,
  }) {
    _show(
        context,
        ExceptionsSnackBars.normalException(
            e: errorMsg ?? 'Unknown Exception'));
  }

  static void unKnownException({@required BuildContext context}) {
    _show(context, ExceptionsSnackBars.unknownException());
  }

  static void netWorkException(BuildContext context) {
    _show(context, ExceptionsSnackBars.networkException());
  }

  static void error(BuildContext context, String errorMsg) {
    _show(
      context,
      ExceptionsSnackBars.errorSnackBar(context: context, e: errorMsg),
    );
  }
}
