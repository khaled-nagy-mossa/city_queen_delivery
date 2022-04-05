import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../../common/const/app_data.dart';

class MapButton extends StatelessWidget {
  final VoidCallback onTap;

  const MapButton({@required this.onTap, Key key}) : super(key: key);

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
            Assets.images.map,
            color: AppData.secondaryColor,
            height: 25.0,
          ),
          const SizedBox(width: 10.0),
          const Text(
            'View In Map',
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
