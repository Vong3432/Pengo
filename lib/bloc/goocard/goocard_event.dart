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

class LoadGooCard extends GoocardEvent {
  const LoadGooCard(
      {this.logs,
      this.logLimit,
      this.records,
      this.recordLimit,
      this.creditPoints});

  final int? logs;
  final int? logLimit;
  final int? records;
  final int? recordLimit;
  final int? creditPoints;
}
