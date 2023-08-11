import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeInAndOutProvider extends ChangeNotifier {
  String _timeIn = '';
  String _timeOut = '';


  String get timeIn => _timeIn;
  String get timeOut => _timeOut;
  String get workTime => _computeworktime();
  String get overtime => _computeovertime();

  storeTimeIn(newTimeIn) {
    _timeIn = newTimeIn;
  }

  storeTimeOut(newTimeOut) {
    _timeOut = newTimeOut;
  }

  _computeworktime() {
    String time1 = _timeIn;
    String time2 = _timeOut;

    DateFormat format = DateFormat("h:mm a");

    DateTime dt1 = format.parse(time1);
    DateTime dt2 = format.parse(time2);

    Duration duration = dt2.difference(dt1);

    return duration.inHours.toString() +
        duration.inMinutes.remainder(60).toString();
  }

  _computeovertime() {
    // _timeIn = newTimeIn;
  }
}
