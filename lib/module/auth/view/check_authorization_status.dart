import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widget/app_bar/default_app_bar.dart';

class CheckAuthorizationStatus extends StatelessWidget {
  const CheckAuthorizationStatus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(title: Text('CheckAuthorizationStatus'.tr)),
        body: Center(
          child: Text('Hello,World'.tr),
        ));
  }
}
