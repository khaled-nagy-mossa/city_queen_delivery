import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/default_body.dart';
import '../widget/exception.dart';

class ExceptionView extends StatelessWidget {
  final String exceptionMsg;
  final String title;
  final RefreshCallback onRefresh;
  final bool showHomeButton;
  final String imagePath;
  final Size size;

  const ExceptionView({
    @required this.exceptionMsg,
    this.title = 'AN_ERROR_HAS_OCCURRED',
    this.onRefresh,
    this.showHomeButton = false,
    this.imagePath,
    this.size,
  }) : assert(exceptionMsg != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: Text(title.tr)),
      body: DefaultBody(
        child: ExceptionWidget(
          exceptionMsg: exceptionMsg,
          imagePath: imagePath,
          size: size,
          onRefresh: onRefresh,
          showHomeButton: showHomeButton,
        ),
      ),
    );
  }
}
