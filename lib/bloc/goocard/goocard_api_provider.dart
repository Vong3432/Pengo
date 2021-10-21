import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/helpers/api/api_helper.dart';
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
}
