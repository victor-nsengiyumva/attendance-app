import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeInAndOutProvider extends ChangeNotifier {
  String _timeIn = '';
  String _timeOut = '';
  Duration? _finalduration;

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

    if (time1.isEmpty || time2.isEmpty) {
      return '- -';
    } else {
      DateFormat format = DateFormat("h:mm a");

      DateTime dt1 = format.parse(time1);
      DateTime dt2 = format.parse(time2);

      Duration duration = dt2.difference(dt1);

      _finalduration = duration;

      String finalTime =
          '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';

      return finalTime;
    }
  }

  _computeovertime() {
    if (_timeIn.isEmpty || _timeOut.isEmpty) {
      return 'Oh 00m';
    } else if (_finalduration! < const Duration(hours: 9, minutes: 01)) {
      return '0h 00m';
    } else {
      return '${_finalduration!.inHours - 9}h ${_finalduration!.inMinutes.remainder(60)}m';
    }
  }

  void clear() {
    _timeIn = '';
    _timeOut = '';
    notifyListeners();
  }
}
