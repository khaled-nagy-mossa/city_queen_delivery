import 'package:delivery/module/statistics/model/driver_profile.dart';
import 'package:delivery/module/statistics/repo/repo.dart';
import 'package:flutter/material.dart';

abstract class DeliveryService {
  const DeliveryService();

  static Future driverProfile({
    @required int driverId,
    @required String startMonth,
    @required String endMonth,
  }) async {
    assert(driverId != null);
    assert(startMonth != null);
    assert(endMonth != null);

    try {
      final res = await DeliveryRepo.driverProfile(
        driverId: driverId,
        startMonth: startMonth,
        endMonth: endMonth,
      );

      if (res.hasError) return res.msg;

      return DriverProfile.fromMap(
        res.json['result']['data'][0] as Map<String, dynamic>,
      );
    } catch (e) {
      return e.toString();
    }
  }
}
