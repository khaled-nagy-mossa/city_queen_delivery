import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class GlobalRepo {
  static Future<SuperResponseModel> updateDeliveryLocation(
      {@required double lat, @required double lng}) async {
    assert(lat != null);
    assert(lng != null);

    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(GlobalAPIs.updateLocation),
        header: await API.header(),
        body: json.encoder.convert({'lat': lat, 'lng': lng}),
      ),
    );
  }
}
