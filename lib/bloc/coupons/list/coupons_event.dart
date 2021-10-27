part of 'coupons_bloc.dart';

abstract class CouponsEvent extends Equatable {
  const CouponsEvent();

  @override
  List<Object> get props => [];
}

class FetchCoupons extends CouponsEvent {
  const FetchCoupons(this.filterType);
  final CouponsFilterType filterType;
}
