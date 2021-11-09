import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/bloc/records/booking_record_bloc.dart';
import 'package:pengo/helpers/storage/shared_preferences_helper.dart';
import 'package:pengo/models/auth_model.dart';
import 'package:pengo/ui/booking-records/booking_record_listing_view.dart';
import 'package:pengo/ui/home/widgets/home_h_listview.dart';
import 'package:pengo/ui/home/widgets/self_booking_item.dart';
import 'package:pengo/ui/widgets/api/loading.dart';

class SelfBookingList extends StatefulWidget {
  const SelfBookingList({Key? key, this.auth}) : super(key: key);

  final Auth? auth;

  @override
  _SelfBookingListState createState() => _SelfBookingListState();
}

class _SelfBookingListState extends State<SelfBookingList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: BlocBuilder<BookingRecordBloc, BookingRecordState>(
        builder: (BuildContext context, BookingRecordState state) {
          if (state is BookingRecordsLoading) {
            return const LoadingWidget();
          } else if (state is BookingRecordsLoaded) {
            if (state.records.isEmpty) {
              return Container();
            }
            return HomeHListView(
              onTapSeeAll: () {
                Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        const BookingRecordList(),
                  ),
                );
              },
              title: "My Booking",
              children: List.generate(
                state.records.length,
                (int index) => SelfBookingItem(
                  record: state.records[index],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<void> _loadRecords() async {
    BlocProvider.of<BookingRecordBloc>(context).add(const FetchRecordsEvent(
      limit: 3,
      isUsed: 0,
    ));
  }
}
