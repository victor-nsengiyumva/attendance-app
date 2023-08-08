import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  TimeOfDay? _time;

  TimeOfDay? get time => _time;

  upDate(TimeOfDay newError) {
    _time = newError;
  }

  upDate2(TimeOfDay newError) {
    _time = newError;

    notifyListeners();
  }
}
