import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/item_validation_model.dart';

class BookingItemApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingItem>> fetchBookingItems({
    int? catId,
    int? sortDate,
    int? sortDistance,
    int? km,
    String? name,
    int? price,
    int? limit,
    bool? searchKeywordOnly = false,
  }) async {
    try {
      final Map<String, dynamic> _qs = <String, dynamic>{};
      if (name != null) _qs["name"] = name;
      if (limit != null) _qs["limit"] = limit;
      if (catId != null) _qs["category_id"] = catId;

      debugPrint("s $searchKeywordOnly");

      if (searchKeywordOnly == false || searchKeywordOnly == null) {
        if (sortDate == 1) {
          _qs["sort_date"] = sortDate;
        } else if (sortDistance == 1) {
          _qs["sort_distance"] = 1;
        }
        if (await GeoHelper().currentPos()?["latitude"] != null &&
            await GeoHelper().currentPos()?["longitude"] != null) {
          _qs["lng"] = await GeoHelper().currentPos()!["longitude"];
          _qs["lat"] = await GeoHelper().currentPos()!["latitude"];
        }
        if (price != null) _qs["price"] = price;
        if (km != null) _qs["km"] = km;
      }

      debugPrint("items qs: $_qs");

      final response =
          await _apiHelper.get('/core/booking-items', queryParameters: _qs);
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
      final response = await _apiHelper.get('/core/booking-items/$id');
      final BookingItem data =
          BookingItem.fromJson(response.data['data'] as Map<String, dynamic>);
      return data;
    } catch (e) {
      throw Exception((e as DioError).error);
    }
  }

  Future<BookingItemValidateStatus> validateItemStatus({
    required int id,
  }) async {
    try {
      final response = await _apiHelper.get('/core/validate-item-status/$id');
      final BookingItemValidateStatus status =
          BookingItemValidateStatus.fromJson(
              response.data['data'] as Map<String, dynamic>);
      return status;
    } catch (e) {
      debugPrint("er $e");
      throw Exception((e as DioError).error);
    }
  }
}
