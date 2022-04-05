import '../../../common/config/api.dart';

abstract class OrderAPIs {
  const OrderAPIs();

  ///to get the order data by id
  ///type get
  ///params => no params
  static String getOrder = '${API.baseUrl}/get_order';

  ///to Update Order Address
  ///type Post
  ///params => no params
  static String updateOrder = '${API.baseUrl}/update_order';

  ///to get all Current Orders of delivery man
  ///type Post
  ///Params => currentOrders?limit=10&limit=0
  static String orderList = '${API.baseUrl}/order_list';

  ///to send customer order signature
  ///type Post
  ///Params => no params
  static String signOrder = '${API.baseUrl}/sign_order';
}
