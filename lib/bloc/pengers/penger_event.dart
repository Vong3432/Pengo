part of 'penger_bloc.dart';

abstract class PengerEvent extends Equatable {
  const PengerEvent();

  @override
  List<Object?> get props => [];
}

class FetchPengers extends PengerEvent {
  const FetchPengers();
}

class FetchPopularNearestPengers extends PengerEvent {
  const FetchPopularNearestPengers();
}

class FetchPenger extends PengerEvent {
  const FetchPenger(this.id);

  final String id;
}
