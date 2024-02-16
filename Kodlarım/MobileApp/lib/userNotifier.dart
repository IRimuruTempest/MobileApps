import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int currentUser = -1; // Kullanıcı bilgilerini içeren değişken
  String currentHobby = "none";

  void setCurrentUser(int user) {
    currentUser = user;
    notifyListeners();
  }
  void setCurrentUserHobby (String hobby) {
    currentHobby = hobby;
    notifyListeners();
  }
}