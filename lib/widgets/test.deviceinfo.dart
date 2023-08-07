import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key});

  _checkDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    print(androidInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    _checkDevice();
    return Scaffold(
      body: Container(),
    );
  }
}
