import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:pengo/helpers/storage/shared_preferences_helper.dart';
import 'package:pengo/models/auth_model.dart';
import 'package:pengo/ui/auth/login_view.dart';

class ApiHelper {
  //https://medium.com/flutter-community/implementing-bloc-pattern-using-flutter-bloc-62a62e0319b5

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._constructor() {
    init();
  }
  static final _instance = ApiHelper._constructor();

  void init() {
    SharedPreferencesHelper _helper = SharedPreferencesHelper();
    _dio.interceptors.addAll([
      InterceptorsWrapper(onError:
          (DioError error, ErrorInterceptorHandler errorInterceptorHandler) {
        debugPrint("Error dio: ${error.response?.data['msg'].toString()}");

        errorInterceptorHandler.reject(error);
        if (error.response?.statusCode == 401) {
          debugPrint("401");
          Get.to(const LoginPage());
        }
      }, onRequest:
          (RequestOptions request, RequestInterceptorHandler handler) async {
        _dio.interceptors.requestLock.lock();
        final prefs = await _helper.getKey("user");

        if (prefs != null) {
          final Auth auth =
              Auth.fromJson(jsonDecode(prefs) as Map<String, dynamic>);
          request.headers["Authorization"] = "Bearer ${auth.token}";
        }

        debugPrint("request url: ${request.path}");

        // end
        _dio.interceptors.requestLock.unlock();
        handler.next(request);
      })
    ]);
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: "${dotenv.env['SERVER_URL']}/",
    connectTimeout: 5000, //5
    receiveTimeout: 3000,
  ));

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
    return _dio.get(url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<Map<String, dynamic>>> post(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      bool? isFormData,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    return _dio.post(url,
        data: data != null
            ? (isFormData == true ? FormData.fromMap(data) : data)
            : null,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<Map<String, dynamic>>> put(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      bool? isFormData,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    return _dio.put(url,
        data: data != null
            ? (isFormData == true ? FormData.fromMap(data) : data)
            : null,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<Map<String, dynamic>>> del(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool? isFormData,
    CancelToken? cancelToken,
  }) async {
    return _dio.delete(
      url,
      data: data != null
          ? (isFormData == true ? FormData.fromMap(data) : data)
          : null,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
