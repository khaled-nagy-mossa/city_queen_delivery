import 'package:delivery/module/statistics/model/order_label.dart';

abstract class OrderLabelService {
  const OrderLabelService();

  static List<OrderLabel> orderLabelByMonth(List<OrderLabel> days) {
    final temp = <OrderLabel>[];

    for (final labelDay in days) {
      final index = _contain(temp, labelDay);
      if (index == -1) {
        temp.add(labelDay);
      } else {
        temp[index] = temp[index].copyWith(
          ordersCount: temp[index].ordersCount + labelDay.ordersCount,
        );
      }
    }
    return temp;
  }

  static int _contain(List<OrderLabel> orders, OrderLabel label) {
    for (int index = 0; index < orders.length; index++) {
      final order = orders[index];
      if ('${order.label.month}-${order.label.year}' ==
          '${label.label.month}-${label.label.year}') {
        return index;
      }
    }
    return -1;
  }
}
