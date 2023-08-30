import 'package:flutter/material.dart';

class CheckinsAndoutsProvider extends ChangeNotifier {
   List<String> _checkins = [];
   List<String> _checkouts = [];

  List get getcheckins => _checkins;
  List get getcheckouts => _checkouts;

  addCheckins(newCheckins) {
    _checkins = newCheckins;
  }

  addCheckouts(newCheckouts) {
    _checkouts = newCheckouts;
  }
}
