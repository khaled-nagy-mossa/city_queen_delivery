import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/assets/assets.dart';
import '../../chat/common/chat_view_imports.dart';
import 'collected_money_item.dart';

class CollectedMoneyWidget extends StatelessWidget {
  final String totalEarning;
  final String totalCollected;

  const CollectedMoneyWidget({
    @required this.totalEarning,
    @required this.totalCollected,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: CollectedMoneyItem(
                svgPath: Assets.images.hand,
                title: 'TOTAL_COLLECTED'.tr,
                money: totalCollected,
              ),
            ),
            Expanded(
              child: CollectedMoneyItem(
                svgPath: Assets.images.dollar,
                title: 'TOTAL_EARNING'.tr,
                money: totalEarning,
              ),
            )
          ],
        ),
      ),
    );
  }
}
