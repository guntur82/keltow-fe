import 'package:flutter_project/models/user.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    level: '',
    password: '',
    alamat: '',
    no_hp: '',
    access_token: '',
    gambar: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
