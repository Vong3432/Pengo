import 'package:dio/dio.dart';

class ResponseModel {
  const ResponseModel({
    this.msg,
    this.statusCode,
    this.data,
  });

  factory ResponseModel.fromResponse(Response res) {
    return ResponseModel(
      statusCode: res.statusCode,
      // ignore: prefer_null_aware_operators
      msg: res.data['msg'] != null ? res.data['msg'].toString() : null,
      data: res.data['data'],
    );
  }

  final String? msg;
  final int? statusCode;
  final dynamic data;
}
