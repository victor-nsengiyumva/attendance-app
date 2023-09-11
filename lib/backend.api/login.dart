import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> loginPF(String pf) async {
  // const String baseUrl = '';
  String url = 'https://attendance-app-backend.up.railway.app/users/auth/login';

  // you can listen to this server remotely by using this IPv4 address of the device and the port to listen on
  Map<dynamic, dynamic> data = {
    "PF": pf,
  };

  String jsonData = jsonEncode(data);
  print(jsonData);

  final response = await http.post(
    Uri.parse(url),
    body: jsonData,
    headers: {
      'Content-Type':
          'application/json', // strictly Add the Content-Type header
    },
  );
  if (response.statusCode == 200) {
    String value = response.body;
    print(response.body);
    return response.body;
  } else {
    print('status error ----------');

    return false;
  }
}
