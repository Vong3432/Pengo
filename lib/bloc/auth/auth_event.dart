part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent(this.phone, this.password);
  final String phone;
  final String password;
}

class RegisterEvent extends AuthEvent {
  const RegisterEvent({
    required this.phone,
    required this.password,
    required this.username,
    required this.email,
    required this.pin,
    required this.avatar,
  });
  final String phone;
  final String password;
  final String username;
  final String email;
  final String pin;
  final XFile avatar;
}

class LogoutEvent extends AuthEvent {}
