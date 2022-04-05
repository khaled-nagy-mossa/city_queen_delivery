import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../common/assets/assets.dart';
import '../../../../main.dart';
import '../../../../widget/app_bar/default_app_bar.dart';
import '../../../../widget/app_dialog/app_dialog.dart';
import '../../../../widget/default_body.dart';
import '../../../../widget/elevated_button_extension.dart';

class OrderDeliveredView extends StatelessWidget {
  static const routeName = '/order_delivered_view';

  final int orderId;

  const OrderDeliveredView({@required this.orderId, Key key})
      : assert(orderId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: DefaultAppBar(
            title: Row(
          children: [
            Text('Order'.tr),
            Text(' #$orderId'),
          ],
        )),
        body: DefaultBody(
          child: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(child: Container()),
                SvgPicture.asset(Assets.images.successful),
                const SizedBox(height: 30.0),
                const Text(
                  'Order Successfully Delivered',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                Expanded(flex: 10, child: Container()),
                ElevatedButton(
                  onPressed: () async {
                    await AppRoutes.pushAndRemoveUntil(
                      context,
                      const StartApplicationView(),
                    );
                    AppDialog.orderSubmitted(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40.0),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                ).toGradient(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
