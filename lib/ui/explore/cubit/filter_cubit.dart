import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pengo/bloc/pengers/penger_bloc.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void filter({
    ExploreListFilter? filterType,
    FilterStatus? status,
    int? price,
    int? km,
    ExploreListSorting? sortBy,
    String? name,
  }) {
    emit(state.copyState(
      status: FilterStatus.loading,
      filterType: filterType,
      price: price,
      km: km,
      sortBy: sortBy,
      name: name,
    ));
  }
}
