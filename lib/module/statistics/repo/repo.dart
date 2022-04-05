import 'dart:convert';

import 'package:delivery/common/config/api.dart';
import 'package:delivery/module/statistics/config/network.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';
import 'package:flutter/material.dart';

abstract class DeliveryRepo {
  const DeliveryRepo();

  static Future<SuperResponseModel> driverProfile({
    @required int driverId,
    @required String startMonth,
    @required String endMonth,
  }) async {
    assert(driverId != null);
    assert(startMonth != null);
    assert(endMonth != null);

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(DeliveryApis.driverProfile),
        header: await API.header(),
        body: json.encoder.convert({
          "driver_id": driverId,
          "start_month": startMonth,
          "end_month": endMonth,
        }),
      ),
    );
  }
}
