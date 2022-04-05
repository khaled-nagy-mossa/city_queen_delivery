import 'package:delivery/common/const/app_data.dart';
import 'package:flutter/material.dart';

class OrdersDataItem extends StatelessWidget {
  const OrdersDataItem({
    @required this.number,
    @required this.title,
    Key key,
  }) : super(key: key);
  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 15.0,
                    width: 15.0,
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      gradient: AppData.gradient,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    title,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Text(
                number.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
