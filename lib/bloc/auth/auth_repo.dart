import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pengo/bloc/auth/auth_api_provider.dart';
import 'package:pengo/models/auth_model.dart';

class AuthRepo {
  factory AuthRepo() {
    return _instance;
  }

  AuthRepo._constructor();

  static final AuthRepo _instance = AuthRepo._constructor();
  final AuthApiProvider _authApiProvider = AuthApiProvider();

  Future<bool> checkPhone(String phone) async =>
      _authApiProvider.checkPhoneExist(phone);

  Future<bool> checkEmail(String email) async =>
      _authApiProvider.checkEmailExist(email);

  Future<Auth> login(String phone, String password) async =>
      _authApiProvider.login(phone, password);

  Future<Auth> register({
    required String phone,
    required String password,
    required String username,
    required String email,
    required XFile avatar,
    required String pin,
  }) async =>
      _authApiProvider.register(
          phone: phone,
          password: password,
          username: username,
          email: email,
          pin: pin,
          avatar: avatar);
}
