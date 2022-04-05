import 'package:flutter/material.dart';

class OrderPriceWidget extends StatelessWidget {
  final String price;
  final String title;

  const OrderPriceWidget({
    @required this.price,
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          price ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          title ?? '',
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
