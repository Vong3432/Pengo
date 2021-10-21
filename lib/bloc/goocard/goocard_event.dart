part of 'goocard_bloc.dart';

abstract class GoocardEvent extends Equatable {
  const GoocardEvent();

  @override
  List<Object> get props => [];
}

class VerifyGooCard extends GoocardEvent {
  const VerifyGooCard(this.pin);
  final String pin;
}
