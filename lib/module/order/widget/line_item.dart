import 'dart:developer';

import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../common/config/api.dart';
import '../../../model/order/order_line.dart';
import '../../product/view/product.dart';

class LineItem extends StatelessWidget {
  final OrderLine line;

  const LineItem({@required this.line}) : assert(line != null);

  @override
  Widget build(BuildContext context) {
    try {
      return GestureDetector(
        onTap: () {
          AppRoutes.push(
            context,
            ProductView(productId: line.productTemplateId),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 55.0,
                    maxWidth: 55.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(API.imageUrl(line.image)),
                    ),
                  ),
                ),
                title: Text(line.name),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Price: ${line.priceUnit}'.tr),
                        Text('Quantity: ${line.qty}'.tr),
                      ],
                    ),
                    Text('Total Amount: ${line.subtotal.toString()}'.tr),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      log('Exception in LineItem : $e'.tr);
      return const SizedBox();
    }
  }
}
