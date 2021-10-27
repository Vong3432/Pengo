import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pengo/bloc/coupons/coupons_repo.dart';
import 'package:pengo/models/coupon_model.dart';
import 'package:pengo/models/response_model.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(const CouponState()) {
    on<FetchCoupon>(_fetchCoupon);
    on<RedeemCoupon>(_redeem);
  }

  final CouponRepo _repo = CouponRepo();

  Future<void> _fetchCoupon(
      FetchCoupon event, Emitter<CouponState> emit) async {
    try {
      emit(
        state.copyWith(
          status: CouponStatus.loading,
        ),
      );

      final Coupon coupon = await _repo.fetchCoupon(event.id);

      emit(
        state.copyWith(
          status: CouponStatus.success,
          coupon: coupon,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: CouponStatus.failure),
      );
    }
  }

  Future<void> _redeem(RedeemCoupon event, Emitter<CouponState> emit) async {
    try {
      emit(
        state.copyWith(
          redeemCouponStatus: RedeemCouponStatus.loading,
        ),
      );

      final ResponseModel res = await _repo.redeem(event.id);
      final Coupon coupon = await _repo.fetchCoupon(event.id);

      emit(
        state.copyWith(
          redeemCouponStatus: RedeemCouponStatus.success,
          coupon: coupon,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          redeemCouponStatus: RedeemCouponStatus.failure,
          redeemErr: e,
        ),
      );
    }
  }
}
