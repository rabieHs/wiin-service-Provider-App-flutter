import 'package:flutter/material.dart';
import 'package:wiin/data/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
      name: '',
      email: '',
      password: '',
      type: '',
      phone: '',
      id: '',
      token: '');

  UserModel get user => _user;
  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }
}
