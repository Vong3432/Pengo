part of 'coupons_bloc.dart';

enum CouponsStatus { idle, loading, success, failure }
enum CouponsFilterType { active, redeemed, expired }

class CouponsState extends Equatable {
  const CouponsState({
    this.coupons = const <Coupon>[],
    this.status = CouponsStatus.idle,
    this.filterType = CouponsFilterType.active,
  });

  CouponsState copyWith({
    List<Coupon>? coupons,
    CouponsFilterType? filterType,
    CouponsStatus? status,
  }) {
    return CouponsState(
      coupons: coupons ?? this.coupons,
      filterType: filterType ?? this.filterType,
      status: status ?? this.status,
    );
  }

  final List<Coupon> coupons;
  final CouponsFilterType filterType;
  final CouponsStatus status;

  @override
  List<Object> get props => [coupons, filterType, status];
}
