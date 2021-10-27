import 'package:pengo/bloc/coupons/coupons_api_provider.dart';
import 'package:pengo/bloc/coupons/list/coupons_bloc.dart';
import 'package:pengo/models/coupon_model.dart';
import 'package:pengo/models/response_model.dart';

class CouponRepo {
  factory CouponRepo() {
    return _instance;
  }

  CouponRepo._constructor();

  static final CouponRepo _instance = CouponRepo._constructor();
  final CouponApiProvider _couponApiProvider = CouponApiProvider();

  Future<List<Coupon>> fetchCoupons({CouponsFilterType? type}) async =>
      _couponApiProvider.fetchCoupons(type: type);

  Future<Coupon> fetchCoupon(int id) async =>
      _couponApiProvider.fetchCoupon(id);

  Future<ResponseModel> redeem(int id) async => _couponApiProvider.redeem(id);
}
