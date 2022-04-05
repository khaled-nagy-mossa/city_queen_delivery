import 'dart:async';
import 'dart:convert';

import 'package:http_helper/http_helper.dart';
import 'package:http_helper/model/super_response_model.dart';

import '../../../common/config/api.dart';
import '../config/config.dart';

abstract class HomeViewRepo {
  const HomeViewRepo();

  // get all home page data
  // header : Content-Type application/json
  static Future<SuperResponseModel> homePage() async {
    return HttpHelper.simpleRequest(
      HttpHelper.post(
        HttpHelper.url(HomeAPIs.driverHome),
        header: await API.header(),
        body: json.encoder.convert(<String , dynamic>{}),
      ),
    );
  }
}
