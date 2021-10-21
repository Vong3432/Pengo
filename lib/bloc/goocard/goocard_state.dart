part of 'goocard_bloc.dart';

abstract class GoocardState extends Equatable {
  const GoocardState();

  @override
  List<Object> get props => [];
}

class GoocardInitial extends GoocardState {}

class GoocardVerifying extends GoocardState {}

class GoocardVerifySuccess extends GoocardState {
  const GoocardVerifySuccess(this.response);

  final ResponseModel response;
}

class GoocardVeriyFailed extends GoocardState {
  const GoocardVeriyFailed(this.e);

  final Object e;
}
