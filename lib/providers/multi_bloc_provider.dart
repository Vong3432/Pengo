import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/ui/penger/booking/booking_cubit.dart';

List<BlocProvider<dynamic>> multiBlocProviders(BuildContext context) {
  return <BlocProvider<dynamic>>[
    BlocProvider<BookingCubit>(
      create: (BuildContext context) => BookingCubit(),
    ),
  ];
}
