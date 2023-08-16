import 'package:flutter/material.dart';

class ErrorProvider extends ChangeNotifier {
  String _error = "";

  String get error => _error;

  void upDate(String newError) {
    _error = newError;
  }

  void upDate2(String newError) {
    _error = newError;
    notifyListeners();
  }

  void clear() {
    _error = '';
    notifyListeners();
  }
}
