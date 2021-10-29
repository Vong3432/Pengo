import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/models/penger_model.dart';

class PengerApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<Penger>> fetchPengers({
    int? sortDate,
    int? sortDistance,
    int? km,
    String? name,
    int? limit,
    bool? searchKeywordOnly = false,
  }) async {
    try {
      final Map<String, dynamic> _qs = <String, dynamic>{};
      if (name != null) _qs["name"] = name;

      if (limit != null) {
        _qs["limit"] = limit;
      }

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
        if (km != null) _qs["km"] = km;
      }

      debugPrint(_qs.toString());

      final response =
          await _apiHelper.get('/core/pengers', queryParameters: _qs);
      final data = response.data['data'] as List;
      final List<Penger> pengers = List<Penger>.from(
          data.map((i) => Penger.fromJson(i as Map<String, dynamic>)));
      return pengers;
    } catch (e) {
      debugPrint("err $e");
      throw Exception(e);
    }
  }

  Future<List<Penger>> fetchNearestPengers({int? limit, int? pageNum}) async {
    try {
      final response = await _apiHelper.get(
          '/core/nearest-pengers?limit=${limit}',
          queryParameters: {'limit': limit, 'page': pageNum});
      final data = response.data['data'] as List;
      List<Penger> pengers = List<Penger>.from(
          data.map((i) => Penger.fromJson(i as Map<String, dynamic>)));

      return pengers;
    } catch (e) {
      debugPrint(e.toString());

      throw Exception(e);
    }
  }

  Future<List<Penger>> fetchPopularPengers({int? limit, int? pageNum}) async {
    try {
      final response = await _apiHelper.get(
          '/core/popular-pengers?limit=${limit}',
          queryParameters: {'limit': limit, 'page': pageNum});

      final data = response.data['data'] as List;
      List<Penger> pengers = List<Penger>.from(
          data.map((i) => Penger.fromJson(i as Map<String, dynamic>)));

      return pengers;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<Penger> fetchBookingItems(int id, {int? limit, int? pageNum}) async {
    try {
      final response = await _apiHelper.get('/core/pengers/{id}?limit=${limit}',
          queryParameters: {'limit': limit, 'page': pageNum});

      final data = response.data['data'];
      Penger penger = Penger.fromJson(data as Map<String, dynamic>);

      return penger;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
