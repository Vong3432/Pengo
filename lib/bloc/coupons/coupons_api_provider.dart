import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pengo/bloc/coupons/list/coupons_bloc.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/models/coupon_model.dart';
import 'package:pengo/models/response_model.dart';

class CouponApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<Coupon>> fetchCoupons({CouponsFilterType? type}) async {
    try {
      final response = await _apiHelper.get(
        '/pengoo/coupons',
        queryParameters: {
          "active": type == CouponsFilterType.active ? 1 : 0,
          "redeemed": type == CouponsFilterType.redeemed ? 1 : 0,
          "expired": type == CouponsFilterType.expired ? 1 : 0,
        },
      );
      final data = response.data['data'] as List;
      List<Coupon> coupons = List<Coupon>.from(
          data.map((i) => Coupon.fromJson(i as Map<String, dynamic>)));
      return coupons;
    } catch (e) {
      debugPrint("errcoupon: ${e.toString()}");
      throw Exception((e as DioError).error);
    }
  }

  Future<Coupon> fetchCoupon(int id) async {
    try {
      final response = await _apiHelper.get(
        '/core/coupons/$id',
      );
      final Coupon coupon =
          Coupon.fromJson(response.data['data'] as Map<String, dynamic>);
      return coupon;
    } catch (e) {
      debugPrint("errcoupon: ${e.toString()}");
      throw Exception((e as DioError).error);
    }
  }

  Future<ResponseModel> redeem(int id) async {
    try {
      final response =
          await _apiHelper.post('/pengoo/coupons', queryParameters: {
        "id": id,
      });
      final ResponseModel res = ResponseModel.fromResponse(response);
      return res;
    } catch (e) {
      debugPrint("errcoupon: ${e.toString()}");
      throw Exception((e as DioError).error);
    }
  }
}
