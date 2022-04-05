import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../../../common/const/app_data.dart';
import '../../../widget/custom_shadow.dart';

class SignatureBoard extends StatelessWidget {
  final SignatureController controller;

  const SignatureBoard({@required this.controller, Key key})
      : assert(controller != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      child: CustomShadow(
        child: Card(
          elevation: 0.0,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Signature(
            controller: controller,
            height: 400,
            backgroundColor: AppData.mainColor,
          ),
        ),
      ),
    );
  }
}
