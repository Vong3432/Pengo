import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pengo/bloc/coupons/coupons_repo.dart';
import 'package:pengo/models/coupon_model.dart';

part 'coupons_event.dart';
part 'coupons_state.dart';

class CouponsBloc extends Bloc<CouponsEvent, CouponsState> {
  CouponsBloc() : super(const CouponsState()) {
    on<FetchCoupons>(_fetchCoupons);
  }

  final CouponRepo _repo = CouponRepo();

  Future<void> _fetchCoupons(
      FetchCoupons event, Emitter<CouponsState> emit) async {
    try {
      emit(
        state.copyWith(
          status: CouponsStatus.loading,
          filterType: event.filterType,
        ),
      );

      final List<Coupon> coupons =
          await _repo.fetchCoupons(type: state.filterType);

      emit(
        state.copyWith(
          status: CouponsStatus.success,
          coupons: coupons,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: CouponsStatus.failure),
      );
    }
  }
}
