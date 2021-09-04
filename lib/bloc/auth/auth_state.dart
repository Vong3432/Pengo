part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthenticatingState extends AuthState {}

class AuthenticatedState extends AuthState {
  const AuthenticatedState(this.auth);
  final Auth auth;
}

class NotAuthenticatedState extends AuthState {
  const NotAuthenticatedState(this.err);
  final Object err;
}
