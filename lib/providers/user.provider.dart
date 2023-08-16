import 'package:attendance/models/user.model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get getUser => _user;

  addUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
