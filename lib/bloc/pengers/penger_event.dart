part of 'penger_bloc.dart';

abstract class PengerEvent extends Equatable {
  const PengerEvent();

  @override
  List<Object?> get props => [];
}

class FetchPengers extends PengerEvent {
  const FetchPengers({
    this.sortDate,
    this.km,
    this.name,
    this.sortDistance,
    this.limit,
    this.searchKeywordOnly,
  });

  final int? sortDate;
  final int? sortDistance;
  final int? limit;
  final int? km;
  final String? name;
  final bool? searchKeywordOnly;
}

class FetchPopularNearestPengers extends PengerEvent {
  const FetchPopularNearestPengers();
}

class FetchPenger extends PengerEvent {
  const FetchPenger(this.id);

  final String id;
}
