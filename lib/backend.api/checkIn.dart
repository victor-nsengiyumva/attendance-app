import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> checkIn(
    int userID, String checkInTime, String dateToday) async {
  String url = 'http://192.168.43.145:3000/attendance/checkIn';

  Map<String, dynamic> data = {
    "userID": userID,
    "checkInTime": checkInTime,
    "dateToday": dateToday,
  };

  var jsonData = jsonEncode(data);

  var response = await http.post(
    Uri.parse(url),
    body: jsonData,
    headers: {
      'Content-Type':
          'application/json', // strictly Add the Content-Type header
    },
  );

  // make sure the await tag is included incase the statusCode shows underline error
  if (response.statusCode == 200) {
    print(
        "the response has gone through and there is no problem at the server side");
    print(response.body);
    return response.body;
  } else {
    print("the checkin is fucked at the server side");
    return false;
  }
}
