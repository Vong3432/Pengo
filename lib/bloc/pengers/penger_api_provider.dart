import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/penger_model.dart';

class PengerApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<Penger>> fetchPengers() async {
    try {
      final response = await _apiHelper.get('/core/pengers');
      final List<Penger> pengers = List<Penger>.from(
          (response.data! as List<Map<String, dynamic>>)
              .map((Map<String, dynamic> i) => Penger.fromJson(i)));
      return pengers;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Penger>> fetchNearestPengers({int? limit, int? pageNum}) async {
    try {
      final response = await _apiHelper.get(
          '/core/nearest-pengers?limit=${limit}',
          queryParameters: {'limit': limit, 'page': pageNum});

      final data = response.data['data'] as List;
      List<Penger> pengers =
          List<Penger>.from(data.map((i) => Penger.fromJson(i)));

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
      List<Penger> pengers =
          List<Penger>.from(data.map((i) => Penger.fromJson(i)));

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
      Penger penger = Penger.fromJson(data);

      return penger;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
