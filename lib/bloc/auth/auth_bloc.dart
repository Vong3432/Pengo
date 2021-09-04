import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pengo/bloc/auth/auth_repo.dart';
import 'package:pengo/helpers/storage/shared_preferences_helper.dart';
import 'package:pengo/models/auth_model.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:provider/provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final AuthRepo _authRepo = AuthRepo();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoginEvent) {
      yield* _mapLoginToState(event.phone, event.password);
    }
    if (event is RegisterEvent) {
      yield* _mapRegisterToState(
          password: event.password,
          email: event.email,
          username: event.username,
          phone: event.phone,
          pin: event.pin,
          avatar: event.avatar);
    }
  }

  Stream<AuthState> _mapLoginToState(String phone, String password) async* {
    try {
      yield AuthenticatingState();
      final Auth auth = await _authRepo.login(phone, password);
      String encoded = jsonEncode(auth.toMap());
      await SharedPreferencesHelper().setStr("user", encoded);
      yield AuthenticatedState(auth);
    } catch (e) {
      yield NotAuthenticatedState(e);
    }
  }

  Stream<AuthState> _mapRegisterToState({
    required String password,
    required String email,
    required String username,
    required String phone,
    required String pin,
    required XFile avatar,
  }) async* {
    try {
      yield AuthenticatingState();
      final Auth auth = await _authRepo.register(
          phone: phone,
          password: password,
          username: username,
          email: email,
          avatar: avatar,
          pin: pin);
      String encoded = jsonEncode(auth.toMap());
      await SharedPreferencesHelper().setStr("user", encoded);
      yield AuthenticatedState(auth);
    } catch (e) {
      yield NotAuthenticatedState(e);
    }
  }
}
