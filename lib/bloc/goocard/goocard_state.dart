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

class GoocardLoadInitial extends GoocardState {}

class GoocardLoading extends GoocardState {}

class GoocardLoadSuccess extends GoocardState {
  const GoocardLoadSuccess(this.goocard);

  final Goocard goocard;
}

class GoocardLoadFailed extends GoocardState {
  const GoocardLoadFailed(this.e);

  final Object e;
}
