import 'package:attendance/models/dateLogs.model.dart';
import 'package:flutter/material.dart';

class DateLogsModelProvider extends ChangeNotifier {
  List<DateLogsModel> _dateLogsList = [];

  List<DateLogsModel> get getdateLogsList => _dateLogsList;

  updateList(newModel) {
    _dateLogsList.add(newModel);
  }

  void clear() {
    _dateLogsList = [];
    notifyListeners();
  }
}
