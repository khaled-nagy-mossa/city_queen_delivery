import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/const/app_data.dart';
import '../../chat/common/chat_view_imports.dart';

class CollectedMoneyItem extends StatelessWidget {
  final String svgPath;
  final String title;
  final String money;

  const CollectedMoneyItem({
    @required this.svgPath,
    @required this.title,
    @required this.money,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 70.0,
          minHeight: 70.0,
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10.0),
            constraints: const BoxConstraints(maxHeight: 55.0, maxWidth: 55.0),
            decoration: BoxDecoration(
              gradient: AppData.gradient,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgPath, color: Colors.white),
          ),
          title: FittedBox(
            child: Text(
              title,
              style: const TextStyle(
                color: AppData.secondaryColor,
                fontSize: 10.0,
              ),
            ),
          ),
          subtitle: Container(
            constraints: const BoxConstraints(),
            height: 20.0,
            child: FittedBox(
              child: Text(
                money,
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 14.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
