part of 'filter_cubit.dart';

enum ExploreListFilter { items, pengers }
enum ExploreListSorting { distance, date }
enum FilterStatus { idle, loading, success, failure }

class FilterState extends Equatable {
  const FilterState({
    this.name,
    this.filterType = ExploreListFilter.items,
    this.status = FilterStatus.idle,
    this.price,
    this.km,
    this.sortBy,
  });

  FilterState copyState({
    ExploreListFilter? filterType,
    FilterStatus? status,
    int? price,
    int? km,
    ExploreListSorting? sortBy,
    String? name,
  }) {
    return FilterState(
      filterType: filterType ?? this.filterType,
      status: status ?? this.status,
      price: price,
      km: km,
      sortBy: sortBy,
      name: name,
    );
  }

  final ExploreListFilter filterType;
  final FilterStatus status;
  final int? price;
  final String? name;
  final int? km;
  final ExploreListSorting? sortBy;

  @override
  List<Object?> get props => [filterType, status, price, name, km, sortBy];
}
