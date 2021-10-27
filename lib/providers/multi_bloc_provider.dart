import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/bloc/auth/auth_bloc.dart';
import 'package:pengo/bloc/booking-categories/booking_category_bloc.dart';
import 'package:pengo/bloc/booking-items/view_booking_item_bloc.dart';
import 'package:pengo/bloc/coupons/list/coupons_bloc.dart';
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
    BlocProvider<BookingCategoryBloc>(
      create: (BuildContext context) => BookingCategoryBloc(),
    ),
    BlocProvider<ViewItemBloc>(
      create: (BuildContext context) => ViewItemBloc(),
    ),
    BlocProvider<CouponsBloc>(
      create: (BuildContext context) => CouponsBloc(),
    ),
  ];
}
