import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../common/const/app_data.dart';

extension ElevatedButtonExtension on ElevatedButton {
  ///get the default button theme from theme data file
  ElevatedButtonThemeData _btnDefaultTheme(BuildContext context) {
    try {
      return Theme?.of(context)?.elevatedButtonTheme;
    } catch (e) {
      log('Exception in ElevatedButtonExtension._btnDefaultTheme : $e'.tr);
      return const ElevatedButtonThemeData();
    }
  }

  ///if style.shape == null ->
  /// get the default button shape from the theme data file
  OutlinedBorder _btnShape(BuildContext context) {
    try {
      return style?.shape?.resolve({}) ??
          _btnDefaultTheme(context)?.style?.shape?.resolve({});
    } catch (e) {
      log('Exception in ElevatedButtonExtension._btnShape : $e'.tr);
      return const RoundedRectangleBorder();
    }
  }

  ///if style.elevation == null ->
  /// get the default button elevation from the theme data file
  double _btnElevation(BuildContext context) {
    try {
      return style?.elevation?.resolve({}) ??
          _btnDefaultTheme(context)?.style?.elevation?.resolve({});
    } catch (e) {
      log('Exception in ElevatedButtonExtension._btnElevation : $e'.tr);
      return 2.0;
    }
  }

  ButtonStyle _btnStyle(BuildContext context) {
    if (style != null) {
      return style?.copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: MaterialStateProperty.all<double>(0.0),
      );
    } else {
      final btnStyle = _btnDefaultTheme(context).style.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: MaterialStateProperty.all<double>(0.0),
          );

      return btnStyle;
    }
  }

  // ButtonStyle _btnStyle(BuildContext context) {
  //   try {
  //     if (style != null) {
  //       return style?.copyWith(
  //         backgroundColor: MaterialStateProperty.all<Color>(
  //           Colors.transparent,
  //         ),
  //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //         elevation: MaterialStateProperty.all<double>(0.0),
  //       );
  //     } else {
  //       final btnStyle = _btnDefaultTheme(context).style;
  //
  //       btnStyle.copyWith(
  //         backgroundColor: MaterialStateProperty.all<Color>(
  //           Colors.transparent,
  //         ),
  //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //         elevation: MaterialStateProperty.all<double>(0.0),
  //       );
  //
  //       return btnStyle;
  //     }
  //   } catch (e) {
  //     log('Exception in ElevatedButtonExtension._btnStyle : $e'.tr;
  //     return style;
  //   }
  // }

  Widget toGradient(BuildContext context, {Gradient gradient}) {
    try {
      return Card(
        margin: EdgeInsets.zero,
        shape: _btnShape(context),
        elevation: _btnElevation(context),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(gradient: gradient ?? AppData.gradient),
          child: ElevatedButton(
            onPressed: onPressed,
            style: _btnStyle(context),
            child: child,
          ),
        ),
      );
    } catch (e) {
      log('Exception in ElevatedButtonExtension.toGradient : $e'.tr);
      return this;
    }
  }
}
