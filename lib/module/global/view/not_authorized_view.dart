import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../home/view/home.dart';

class NotAuthorizedView extends StatelessWidget {
  const NotAuthorizedView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: Text('Access Denied!'.tr)),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.images.authorization),
            Text(
              'You Must Sign In To Allow You To Enter This Page'.tr,
              style: Theme.of(context).textTheme.headline6,
            ),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                AppRoutes.pushAndRemoveUntil(context, const HomeView());
              },
              child: Text('Go To Home Page'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
