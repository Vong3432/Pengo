part of 'nearest_penger_bloc.dart';

abstract class NearestPengerState extends Equatable {
  const NearestPengerState();

  @override
  List<Object> get props => [];
}

class NearestPengerInitial extends NearestPengerState {}

class NearestPengersInitial extends NearestPengerState {}

class NearestPengersLoading extends NearestPengerState {}

class NearestPengersLoaded extends NearestPengerState {
  const NearestPengersLoaded(this.pengers);
  final List<Penger> pengers;
}

class NearestPengersNotLoaded extends NearestPengerState {}
