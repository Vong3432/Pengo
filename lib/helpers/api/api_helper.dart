import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pengo/helpers/storage/shared_preferences_helper.dart';

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
        debugPrint("Error dio: ${error.message}");

        errorInterceptorHandler.reject(error);
      }, onRequest:
          (RequestOptions request, RequestInterceptorHandler handler) async {
        _dio.interceptors.requestLock.lock();
        final prefs = await _helper.getKey("user");

        if (prefs != null) {
          final dynamic auth = jsonDecode(prefs);
          request.headers["Authorization"] = "Bearer ${auth['token']}";
        }
        // For hardcode testing
        final hardcode = "${dotenv.env['HARDCODE_TOKEN']}";
        request.headers["Authorization"] = "Bearer $hardcode";

        // end
        _dio.interceptors.requestLock.unlock();
        handler.next(request);
      })
    ]);
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl:
        Platform.isIOS ? 'http://172.20.10.7:3333/' : 'http://10.0.2.2:3333/',
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
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    return _dio.post(url,
        data: data != null ? FormData.fromMap(data) : null,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }
}
