import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/goocard_model.dart';
import 'package:pengo/models/response_model.dart';

class GoocardApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<ResponseModel> verify(String pin) async {
    try {
      final response = await _apiHelper.post(
        '/pengoo/validate-card',
        data: {
          "pin": pin,
        },
      );
      final ResponseModel responseModel = ResponseModel.fromResponse(response);
      return responseModel;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      throw e.response!.data['msg'].toString();
    }
  }

  Future<Goocard> load({
    int? logs,
    int? logLimit,
    int? records,
    int? recordLimit,
    int? creditPoints,
  }) async {
    try {
      final response = await _apiHelper.get(
        '/pengoo/goocard',
        queryParameters: {
          "logs": logs,
          "log_limit": logLimit,
          "records": records,
          "record_limit": recordLimit,
          "credit_point": creditPoints,
        },
      );
      final Goocard goocard =
          Goocard.fromJson(response.data['data'] as Map<String, dynamic>);
      return goocard;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      throw e.response!.data['msg'].toString();
    }
  }
}
