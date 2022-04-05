import 'package:flutter/material.dart';

import 'repo.dart';

abstract class GlobalService {
  const GlobalService();

  static Future<String> updateLocation({
    @required double lat,
    @required double lng,
  }) async {
    assert(lat != null);
    assert(lng != null);

    try {
      final res = await GlobalRepo.updateDeliveryLocation(lat: lat, lng: lng);

      if (res.hasError) throw res.msg;

      return '';
    } catch (e) {
      return e.toString();
    }
  }
}
