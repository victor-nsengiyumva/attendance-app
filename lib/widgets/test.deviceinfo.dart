import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';


class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key});

  _checkDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // ignore: unused_local_variable
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  }

  @override
  Widget build(BuildContext context) {
    _checkDevice();
    return Scaffold(
      body: Container(),
    );
  }
}
