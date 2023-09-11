import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/timeInAndOut.provider.dart';

Future<dynamic> checkIn(int userID, String checkInTime, String dateToday,
    TimeInAndOutProvider timeInAndOutProvider) async {
  String url = 'https://attendance-app-backend.up.railway.app/attendance/checkIn';

  Map<String, dynamic> data = {
    "userID": userID,
    "checkInTime": checkInTime,
    "dateToday": dateToday,
  };

  var jsonData = jsonEncode(data);
  try {
    var response = await http.post(
      Uri.parse(url),
      body: jsonData,
      headers: {
        'Content-Type':
            'application/json', // strictly Add the Content-Type header
      },
    ).timeout(const Duration(
        seconds:
            10)); // this timeout tell the http request to return an error if the connection has failed for 10 secs

    // make sure the await tag is included incase the statusCode shows underline error
    if (response.statusCode == 200) {
      print(
          "the response has gone through and there is no problem at the server side");
      var data = jsonDecode(response.body);
      String timeIn = data['checkInTime'];
      timeInAndOutProvider.storeTimeIn(timeIn);
      print(data);
      return true;
    } else {
      print("the checkin is fucked at the server side");
      return false;
    }
  } catch (e) {
    return 'network error';
  }
}
