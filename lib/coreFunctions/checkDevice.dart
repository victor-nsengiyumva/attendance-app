import 'package:attendance/providers/user.provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<bool> checkDevice(currentUserDeviceID) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  String deviceID = androidInfo.id;

  if (deviceID == currentUserDeviceID) {
    return true;
  } else {
    return false;
  }

}
