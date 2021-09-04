import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/bloc/auth/auth_bloc.dart';
import 'package:pengo/bloc/pengers/penger_bloc.dart';
import 'package:pengo/bloc/records/booking_record_bloc.dart';

List<BlocProvider<dynamic>> multiBlocProviders(BuildContext context) {
  return <BlocProvider<dynamic>>[
    BlocProvider<PengerBloc>(
      create: (BuildContext context) => PengerBloc(),
    ),
    BlocProvider<BookingRecordBloc>(
      create: (BuildContext context) => BookingRecordBloc(),
    ),
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(),
    ),
  ];
}
