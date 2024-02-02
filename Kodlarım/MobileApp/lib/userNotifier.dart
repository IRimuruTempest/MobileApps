import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int currentUser = -1; // Kullanıcı bilgilerini içeren değişken

  void setCurrentUser(int user) {
    currentUser = user;
    notifyListeners();
  }
}