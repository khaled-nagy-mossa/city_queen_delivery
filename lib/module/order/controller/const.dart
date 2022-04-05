import '../model/order_type_tab_model.dart';

enum OrderType { inDelivery, delivered, all }

const orderTypeTabs = <OrderTypeTapModel>[
  OrderTypeTapModel(
    orderType: OrderType.inDelivery,
    orderTypeParameter: 'in_delivery',
    title: 'In Delivery',
  ),
  OrderTypeTapModel(
    orderType: OrderType.delivered,
    orderTypeParameter: 'done',
    title: 'Done',
  ),
  OrderTypeTapModel(
    orderType: OrderType.all,
    orderTypeParameter: '',
    title: 'All',
  ),
];
