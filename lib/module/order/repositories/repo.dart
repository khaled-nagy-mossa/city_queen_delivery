import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../../../common/const/app_data.dart';
import '../config/config.dart';
import '../model/orders_param.dart';

abstract class OrderRepo {
  const OrderRepo();

  static Future<SuperResponseModel> orders(
      {@required OrdersListParam param}) async {
    assert(param != null);

    final bodyData = <String, dynamic>{
      'for_user': AppData.userRole,
      'status': param.orderTypeParameter,
    };

    var url = OrderAPIs.orderList;
    url += param.parse;

    final bodyParams = <String, dynamic>{};

    for (final key in bodyData.keys) {
      if (bodyData[key] != null && (bodyData[key] as String).isNotEmpty) {
        bodyParams[key] = bodyData[key];
      }
    }

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(url),
        header: await API.header(),
        body: json.encoder.convert(bodyData),
      ),
    );
  }

  static Future<SuperResponseModel> getOrder({
    @required int orderId,
  }) async {
    assert(orderId != null);

    return HttpHelper.simpleRequest(
      HttpHelper.getWithBodyData(
        HttpHelper.url(OrderAPIs.getOrder),
        header: await API.header(),
        body: ''' {\r\n "order_id": $orderId\r\n }''',
      ),
    );
  }

  static Future<SuperResponseModel> updateOrderAddress({
    @required int orderId,
    @required int addressId,
  }) async {
    assert(orderId != null);
    assert(addressId != null);

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(OrderAPIs.updateOrder),
        header: await API.header(),
        body: json.encode({'order_id': orderId, 'address_id': addressId}),
      ),
    );
  }

  static Future<SuperResponseModel> updateOrderStatusToDelivered({
    @required int orderId,
    @required double totalPrice,
  }) async {
    assert(orderId != null);
    assert(totalPrice != null);

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(OrderAPIs.updateOrder),
        header: await API.header(),
        body: json.encode({
          'order_id': orderId,
          'status': 'delivered',
          'total': totalPrice,
        }),
      ),
    );
  }

  static Future<SuperResponseModel> signOrder({
    @required int orderId,
    @required String imageEncoded,
  }) async {
    assert(orderId != null);
    assert(imageEncoded != null);

    return HttpHelper.simpleRequest(HttpHelper.post(
      HttpHelper.url(OrderAPIs.signOrder),
      header: await API.header(),
      body: json.encoder.convert({
        'order_id': orderId,
        'signature': imageEncoded,
      }),
    ));
  }
}
