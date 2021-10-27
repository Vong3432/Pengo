part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object> get props => [];
}

class FetchCoupon extends CouponEvent {
  const FetchCoupon(this.id);
  final int id;
}

class RedeemCoupon extends CouponEvent {
  const RedeemCoupon(this.id);
  final int id;
}
