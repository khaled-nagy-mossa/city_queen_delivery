import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../../common/const/app_data.dart';

class SignatureButton extends StatelessWidget {
  final VoidCallback onTap;

  const SignatureButton({@required this.onTap, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40.0),
        primary: Colors.white,
      ),
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.images.signature,
            color: AppData.secondaryColor,
            height: 25.0,
          ),
          const SizedBox(width: 10.0),
          const Text(
            'Submit a Signature',
            style: TextStyle(
              color: AppData.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
