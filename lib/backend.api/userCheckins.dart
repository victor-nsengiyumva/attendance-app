import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/userCheckinsandCheckouts.provider.dart';

userCheckins(userID, CheckinsAndoutsProvider checkinsAndoutsProvider) async {
  String url = 'http://192.168.43.145:3000/attendance/userCheckins';

  // you can listen to this server remotely by using this IPv4 address of the device and the port to listen on
  Map<dynamic, dynamic> data = {"userID": userID};

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
    var data2 = jsonDecode(response.body);

    checkinsAndoutsProvider.addCheckins(data2);
  } else {
  }
}
