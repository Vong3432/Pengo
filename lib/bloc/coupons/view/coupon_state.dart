part of 'coupon_bloc.dart';

enum CouponStatus { idle, loading, success, failure }
enum RedeemCouponStatus { idle, loading, success, failure }

class CouponState extends Equatable {
  const CouponState({
    this.coupon,
    this.status = CouponStatus.idle,
    this.redeemCouponStatus = RedeemCouponStatus.idle,
    this.redeemErr,
  });

  CouponState copyWith(
      {Coupon? coupon,
      CouponStatus? status,
      RedeemCouponStatus? redeemCouponStatus,
      Object? redeemErr}) {
    return CouponState(
      coupon: coupon ?? this.coupon,
      status: status ?? this.status,
      redeemCouponStatus: redeemCouponStatus ?? RedeemCouponStatus.idle,
      redeemErr: redeemErr,
    );
  }

  final Coupon? coupon;
  final CouponStatus status;
  final RedeemCouponStatus redeemCouponStatus;
  final Object? redeemErr;

  @override
  List<Object?> get props => [coupon, status, redeemCouponStatus, redeemErr];
}
