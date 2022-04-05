import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../module/auth/cubit/auth/cubit.dart';
import '../module/auth/cubit/auth/cubit_extension.dart';
import '../module/global/repo/service.dart';

abstract class LocationMonitor {
  const LocationMonitor();

  static bool _serviceEnabled;
  static final location = Location();
  static PermissionStatus _permissionGranted;
  static double prevCurrentLocationLatitude = 0.0;
  static double prevCurrentLocationLongitude = 0.0;
  static bool sendLocationToServer = true;
  static const int seconds = 30;
  static bool hasInit = false;

  static Future<void> init({@required BuildContext context}) async {
    assert(context != null);

    hasInit = true;

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      Timer.periodic(const Duration(seconds: seconds), (timer) async {
        sendLocationToServer = true;
        if (await location.serviceEnabled() == false) {
          await init(context: context);
        }
      });

      await location.enableBackgroundMode(enable: true);

      location.onLocationChanged.listen((currentLocation) async {
        if (prevCurrentLocationLatitude != currentLocation.latitude ||
            prevCurrentLocationLongitude != currentLocation.longitude) {
          prevCurrentLocationLatitude = currentLocation.latitude;
          prevCurrentLocationLongitude = currentLocation.longitude;

          if (sendLocationToServer) {
            sendLocationToServer = false;
            if (AuthCubit.get(context).signed) {
              final errorMsg = await GlobalService.updateLocation(
                lat: currentLocation.latitude,
                lng: currentLocation.longitude,
              );
              if (errorMsg != null && errorMsg.isNotEmpty) {
                log('Error Msg When Update Location : $errorMsg');
              } else {
                log('location Has Updated : $currentLocation');
              }
            }
          } else {
            log('Server Closed');
          }
        }
      });
    } catch (e) {
      log('Has Exception : ${e.toString()}');
    }
  }

  static Future<void> checkPermissions() async {
    final permissionGrantedResult = await location.hasPermission();
    _permissionGranted = permissionGrantedResult;
  }

  static Future<bool> requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final permissionRequestedResult = await location.requestPermission();
      _permissionGranted = permissionRequestedResult;
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}
