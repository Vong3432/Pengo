import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/booking_item_model.dart';

class BookingItemApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingItem>> fetchBookingItems({int? catId}) async {
    try {
      final response =
          await _apiHelper.get('/core/booking-items', queryParameters: {
        "category_id": catId,
      });
      final data = response.data['data'] as List;
      List<BookingItem> bookingItems = List<BookingItem>.from(
          data.map((i) => BookingItem.fromJson(i as Map<String, dynamic>)));
      return bookingItems;
    } catch (e) {
      debugPrint("err_item: ${e.toString()}");
      throw Exception((e as DioError).error);
    }
  }

  Future<BookingItem> fetchBookingItem({required int id}) async {
    try {
      final response = await _apiHelper.get('/core/booking-items/${id}');
      final BookingItem data =
          BookingItem.fromJson(response.data['data'] as Map<String, dynamic>);
      return data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception((e as DioError).error);
    }
  }
}
