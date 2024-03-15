import 'package:flutter/material.dart';
import 'package:to_do_application/ModelClass/myUser.dart';

class AuthProviders extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser? newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
