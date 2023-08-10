import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/user.provider.dart';

Future<bool> checkRegisteredIn(userID, dateToday) async {
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
    print('yeah this is working');
    print(response.body);
    if (response.body != 'false') {
      return true;
    } else {
      return false;
    }
  } else {
    print(response.body);
    return false;
  }
}


Future<bool> checkRegisteredOut(userID, dateToday) async {
  
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
    print('yeah this is working');
    print(response.body);

    if (response.body != 'false') {
      return true;
    } else {
      return false;
    }
  } else {
    print(response.body);
    return false;
  }
}
