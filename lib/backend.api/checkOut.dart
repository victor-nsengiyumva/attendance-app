import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/timeInAndOut.provider.dart';

Future<dynamic> checkOut(int userID, String checkOutTime, String dateToday,
    TimeInAndOutProvider timeInAndOutProvider) async {
  String url = 'http://192.168.43.145:3000/attendance/checkOut';

  Map<String, dynamic> data = {
    "userID": userID,
    "checkOutTime": checkOutTime,
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
    ).timeout(Duration(seconds: 10));

    // make sure the await tag is included incase the statusCode shows underline error
    if (response.statusCode == 200) {

      var data = jsonDecode(response.body);
      String timeOut = data['checkOutTime'];
      timeInAndOutProvider.storeTimeOut(timeOut);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
