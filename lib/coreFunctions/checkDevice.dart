import 'package:device_info_plus/device_info_plus.dart';


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
