import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/auth_model.dart';

class AuthApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Auth> login(
    String phone,
    String password,
  ) async {
    try {
      final response = await _apiHelper.post(
        'auth/login',
        data: <String, String>{
          "phone": "+6$phone",
          "password": password,
        },
      );
      final auth =
          Auth.fromJson(response.data!['data'] as Map<String, dynamic>);
      return auth;
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  Future<bool> checkPhoneExist(String phone) async {
    final response =
        await _apiHelper.post('auth/check-phone', data: <String, String>{
      "phone": "+6$phone",
    });
    final bool result = response.data!['data']['is_valid'] as bool;
    return result;
  }

  Future<bool> checkEmailExist(String email) async {
    final response =
        await _apiHelper.post('auth/check-email', data: <String, String>{
      "email": email,
    });
    final bool result = response.data!['data']['is_valid'] as bool;
    return result;
  }

  Future<Auth> register({
    required String phone,
    required String password,
    required String username,
    required String email,
    required String pin,
    required int age,
    required XFile avatar,
  }) async {
    try {
      final String fileName = avatar.path.split('/').last;
      final Map<String, dynamic> fd = {
        "phone": "+6$phone",
        "pin": pin,
        "password": password,
        "password_confirmation": password,
        "username": username,
        "email": email,
        "age": age,
        "avatar": await MultipartFile.fromFile(avatar.path, filename: fileName),
      };
      final Response<Map<String, dynamic>> response =
          await _apiHelper.post('/auth/register', data: fd, isFormData: true);
      final Auth auth =
          Auth.fromJson(response.data!['data'] as Map<String, dynamic>);
      return auth;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Auth> updateProfile({
    required int userId,
    String? phone,
    String? password,
    String? username,
    String? email,
    XFile? avatar,
  }) async {
    try {
      final Map<String, dynamic> fd = <String, dynamic>{
        "phone": phone,
        "password": password,
        "username": username,
        "email": email,
        "avatar": avatar != null
            ? await MultipartFile.fromFile(
                avatar.path,
                filename: avatar.path.split('/').last,
              )
            : null,
      };
      final Response<Map<String, dynamic>> response = await _apiHelper.put(
        '/auth/update-profile/$userId',
        data: fd,
        isFormData: true,
      );
      final Auth auth =
          Auth.fromJson(response.data!['data'] as Map<String, dynamic>);
      return auth;
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }
}
