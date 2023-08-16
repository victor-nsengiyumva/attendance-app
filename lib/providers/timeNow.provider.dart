import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  TimeOfDay? _time;

  TimeOfDay? get time => _time;


  // this is called the first time the getTime method is called in the initState or the build method
  // of the clickin page. it cant notify listeners because the widget is still in the process 
  // of building an the listeners are part of the widgets being built at the moment
  // so by notifying listeners is like you are asking the listeners to rebuild before they are even
  // built which is why is added the second upDate2 which is called when the refresh button on the clockin
  // page is pressed and for it it can notify the listeners because they have already been built by now.
  upDate(TimeOfDay newError) {
    _time = newError;
  }


  // this is called when you hit the refresh button
  // i had to add this 
  upDate2(TimeOfDay newError) {
    _time = newError;
    notifyListeners();
  }
}
