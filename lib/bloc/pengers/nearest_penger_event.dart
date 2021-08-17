part of 'nearest_penger_bloc.dart';

abstract class NearestPengerEvent extends Equatable {
  const NearestPengerEvent();

  @override
  List<Object> get props => [];
}

class FetchNearestPengers extends NearestPengerEvent {
  const FetchNearestPengers({this.limit, this.pageNum});
  final int? limit;
  final int? pageNum;
}
