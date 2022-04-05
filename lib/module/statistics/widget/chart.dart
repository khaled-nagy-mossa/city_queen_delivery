import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/const/app_data.dart';
import '../../../main_imports.dart';
import '../model/order_label.dart';
import 'package:get/get.dart';

class ChartWidget extends StatelessWidget {
  final List<OrderLabel> orders;

  const ChartWidget({this.orders, this.onTap, Key key}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (orders == null || orders.isEmpty) return const SizedBox();

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<OrderLabel, String>>[
          LineSeries<OrderLabel, String>(
            dataSource: orders,
            xValueMapper: (order, _) {
              return '${order.label.day}-${order.label.month}';
            },
            yValueMapper: (order, _) {
              return order.ordersCount;
            },
          )
        ],
        title: ChartTitle(
          text: onTap == null ? 'NUMBER_OF_ORDERS'.tr : 'Show All Statistics',
          alignment: Get.locale.languageCode == "ar"
              ? ChartAlignment.far
              : ChartAlignment.near,
          textStyle: const TextStyle(
            color: AppData.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
