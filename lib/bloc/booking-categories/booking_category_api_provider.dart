import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/booking_category_model.dart';

class BookingCategoryApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingCategory>> fetchBookingCategories({int? pengerId}) async {
    try {
      final Map<String, dynamic> parameters = {};

      if (pengerId != null) {
        parameters["penger_id"] = pengerId;
      }

      final response = await _apiHelper.get(
        '/core/booking-categories',
        queryParameters: parameters,
      );
      final data = response.data['data'] as List;

      List<BookingCategory> bookingCategories = List<BookingCategory>.from(
          data.map((i) => BookingCategory.fromJson(i as Map<String, dynamic>)));

      return bookingCategories;
    } catch (e) {
      debugPrint("err cat: ${e.toString()}");
      throw Exception(e);
    }
  }
}
