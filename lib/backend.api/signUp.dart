import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> signup(String PF, String email, String mobile_number,
    String location, String deviceID) async {
  String url =
      'http://192.168.43.145:3000/users/auth/signup'; // you can listen to this server remotely by using this IPv4 address of the device and the port to listen on

  Map<String, dynamic> data = {
    "PF": PF,
    "email": email,
    "mobile_number": mobile_number,
    "location": location,
    "deviceID": deviceID
  };

  String signData = jsonEncode(data);

  var response = await http.post(
    Uri.parse(url),
    body: signData,
    headers: {
      'Content-Type':
          'application/json', // strictly Add the Content-Type header
    },
  );

  if (response.statusCode == 200) {
    response.body;
    print(response.body);
    return response.body;
  } else {
    print('status error ----------');

    return false;
  }
}
