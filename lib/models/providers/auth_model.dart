import 'package:flutter/foundation.dart';
import 'package:pengo/helpers/storage/shared_preferences_helper.dart';
import 'package:pengo/models/auth_model.dart';

class AuthModel extends ChangeNotifier {
  Auth? _user;

  Auth? get user => _user;

  void setUser(Auth u) {
    _user = u;
    notifyListeners();
  }

  Future<void> logoutUser() async {
    _user = null;
    await SharedPreferencesHelper().remove("user");
    notifyListeners();
  }
}
