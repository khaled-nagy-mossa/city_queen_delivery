import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

abstract class AppPermissions {
  static Future<bool> isGrantedLocation() async {
    try {
      await Permission.location.request();
      return Permission.location.isGranted;
    } catch (e) {
      log('Exception in AppPermissions.isGrantedLocation : $e');
      return false;
    }
  }
}
