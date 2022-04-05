import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:signature/signature.dart';

import '../../../../widget/app_bar/default_app_bar.dart';
import '../../../../widget/default_body.dart';
import '../../widget/order_price.dart';
import '../../widget/signature_actions.dart';
import '../../widget/signature_board.dart';
import 'confirm_signature.dart';

class SignatureView extends StatefulWidget {
  static const routeName = '/signature_view';

  final int orderId;
  final String paidAmount;
  final String currency;
  const SignatureView({
    @required this.orderId,
    @required this.paidAmount,
    @required this.currency,
    Key key,
  })  : assert(orderId != null),
        assert(paidAmount != null),
        assert(currency != null),
        super(key: key);

  @override
  _SignatureViewState createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  final _controller = SignatureController(
    penStrokeWidth: 2,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: Text('Signature'.tr)),
      body: DefaultBody(
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              OrderPriceWidget(
                price: '${widget.paidAmount} ${widget.currency}',
                title: 'Paid Amount',
              ),
              Expanded(child: Container()),
              SignatureBoard(controller: _controller),
              Expanded(child: Container()),
              SignatureActions(
                controller: _controller,
                onClear: () {
                  setState(_controller.clear);
                },
                onSubmit: (uint8list) async {
                  await AppRoutes.pushReplacement(
                    context,
                    ConfirmSignatureView(
                      orderId: widget.orderId,
                      uint8list: uint8list,
                      paidAmount: widget.paidAmount,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
