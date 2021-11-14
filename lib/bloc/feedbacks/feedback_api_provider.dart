import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/goocard_model.dart';
import 'package:pengo/models/response_model.dart';

class FeedbackApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<ResponseModel> postReview(
    String title,
    String category,
    String description,
    int recordId,
  ) async {
    try {
      final response = await _apiHelper.post(
        '/core/feedbacks',
        data: {
          "title": title,
          "category": category,
          "description": description,
          "record_id": recordId,
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
