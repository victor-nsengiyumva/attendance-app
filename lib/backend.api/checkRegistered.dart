import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/timeInAndOut.provider.dart';

Future<bool> checkRegisteredIn(
    userID, dateToday, TimeInAndOutProvider timeinandoutprovider) async {
  String url = 'http://192.168.43.145:3000/attendance/checkClockIn';

  // you can listen to this server remotely by using this IPv4 address of the device and the port to listen on
  Map<dynamic, dynamic> data = {"userID": userID, "dateToday": dateToday};

  String jsonData = jsonEncode(data);

  final response = await http.post(
    Uri.parse(url),
    body: jsonData,
    headers: {
      'Content-Type':
          'application/json', // strictly Add the Content-Type header
    },
  );
  if (response.statusCode == 200) {
    if (response.body != 'false') {
      data = jsonDecode(response.body);
      var time = data['checkInTime'];
      timeinandoutprovider.storeTimeIn(time);
      return true;
    } else {
      // timeinandoutprovider.storeTimeIn('');
      return false;
    }
  } else {
  

    return false;
  }
}

Future<bool> checkRegisteredOut(
    userID, dateToday, TimeInAndOutProvider timeinandoutprovider) async {
  String url = 'http://192.168.43.145:3000/attendance/checkClockOut';

  // you can listen to this server remotely by using this IPv4 address of the device and the port to listen on
  Map<dynamic, dynamic> data = {"userID": userID, "dateToday": dateToday};

  String jsonData = jsonEncode(data);

  final response = await http.post(
    Uri.parse(url),
    body: jsonData,
    headers: {
      'Content-Type':
          'application/json', // strictly Add the Content-Type header
    },
  );
  if (response.statusCode == 200) {
  

    if (response.body != 'false') {
      data = jsonDecode(response.body);
      var time = data['checkOutTime'];
      timeinandoutprovider.storeTimeOut(time);
      return true;
    } else {
      // timeinandoutprovider.storeTimeIn('');
      return false;
    }
  } else {
  
    return false;
  }
}
