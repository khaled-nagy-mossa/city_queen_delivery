import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/assets/assets.dart';
import '../model/variant.dart';

class ProductMainData extends StatelessWidget {
  final Variant variant;

  const ProductMainData({@required this.variant}) : assert(variant != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.zero,
      title: Text(
        variant.name ?? '',
        // textAlign: TextAlign.justify,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 5.0),
        child: Text(
          '${variant.currencySymbol}${variant.price}',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: Container(
        constraints: const BoxConstraints(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 15.0),
            GestureDetector(
              onTap: () {
                log('Share Called');
              },
              child: SvgPicture.asset(
                Assets.images.share,
                height: 25.0,
                width: 25.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
