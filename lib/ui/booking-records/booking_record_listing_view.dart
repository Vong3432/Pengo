import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pengo/bloc/records/booking_record_bloc.dart';
import 'package:pengo/bloc/records/booking_record_repo.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/extensions/date_extension.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/toast/toast_helper.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/ui/booking-records/booking_record_detail_view.dart';
import 'package:pengo/ui/booking-records/widgets/booking_card.dart';
import 'package:pengo/ui/widgets/api/loading.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:collection/collection.dart';

class BookingRecordList extends StatefulWidget {
  const BookingRecordList({Key? key}) : super(key: key);

  @override
  _BookingRecordListState createState() => _BookingRecordListState();
}

class _BookingRecordListState extends State<BookingRecordList> {
  final DateRangePickerController _controller = DateRangePickerController();
  List<BookingRecord> _records = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            centerTitle: true,
            shadowColor: secondaryTextColor,
            floating: true,
            elavation: 4,
            title: Text(
              "My Booking",
              style: PengoStyle.title2(context),
            ),
            actions: [
              Visibility(
                visible: _selectedDate != null,
                child: CupertinoButton(
                    child: const Text("Reset"),
                    onPressed: () {
                      setState(() {
                        _controller.selectedDate = null;
                        _selectedDate = null;
                      });
                      _loadRecords(date: _selectedDate);
                    }),
              )
            ],
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.all(18),
                child: SfDateRangePicker(
                  controller: _controller,
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    todayTextStyle: TextStyle(
                      color: secondaryTextColor,
                    ),
                    todayCellDecoration: BoxDecoration(
                      color: secondaryTextColor.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    specialDates: _bookedSpecialDates(),
                  ),
                  // cellBuilder: (
                  //   BuildContext context,
                  //   DateRangePickerCellDetails details,
                  // ) {
                  //   bool isToday = false;

                  //   for (BookingRecord record in _records) {
                  //     // no idea why this plugin is 1 month quicker, so minus 1 month
                  //     final DateTime sub1Month = DateTime(
                  //       details.date.year,
                  //       details.date.month,
                  //       details.date.day,
                  //     );
                  //     // debugPrint("sub1mon ${sub1Month.toLocal()}");
                  //     if (sub1Month.toLocal().isBetweenDate(
                  //           record.bookDate!.startDate!.toLocal(),
                  //           record.bookDate!.endDate!.toLocal(),
                  //         )) {
                  //       isToday = true;
                  //     }
                  //     // debugPrint(
                  //     //     "${details.date.toLocal()} is between ${record.bookDate!.startDate!.toLocal()} and ${record.bookDate!.endDate!.toLocal()} $isToday");
                  //   }

                  //   return DayCell(
                  //     details: details,
                  //     isToday: isToday,
                  //     state: BlocProvider.of<BookingRecordBloc>(context).state,
                  //   );
                  // },
                  showNavigationArrow: true,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    if (args.value is DateTime) {
                      setState(() {
                        _selectedDate = DateTime.parse(args.value.toString());
                      });
                      _loadRecords(date: _selectedDate);
                    }
                  },
                  backgroundColor: greyBgColor,
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
                child: Text(
                  _selectedDate == null
                      ? "All"
                      : "Booking in ${DateFormat().add_yMMMd().format(_selectedDate!.toLocal())}",
                  style: PengoStyle.header(context),
                  textScaleFactor: 1.2,
                ),
              ),
              BlocConsumer<BookingRecordBloc, BookingRecordState>(
                listener: (BuildContext context, BookingRecordState state) {
                  if (state is BookingRecordsLoaded) {
                    if (_records.isEmpty) {
                      setState(() {
                        _records = state.records;
                      });
                    }
                  }
                },
                builder: (BuildContext context, BookingRecordState state) {
                  if (state is BookingRecordsLoading) {
                    return const LoadingWidget();
                  } else if (state is BookingRecordsLoaded) {
                    if (state.records.isEmpty) {
                      return const Center(
                        child: Text("No record..."),
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          bottom: 28,
                          left: 12,
                          right: 12,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final BookingRecord record = state.records[index];
                          return BookingCard(
                            record: record,
                            onCancel: _cancelBooking,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: SECTION_GAP_HEIGHT,
                          );
                        },
                        itemCount: state.records.length,
                      );
                    }
                  }
                  return Container();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  List<DateTime>? _bookedSpecialDates() {
    if (_records.isNotEmpty == false) {
      return const <DateTime>[];
    }

    final List<List<DateTime>> _specialDates =
        _records.map((BookingRecord record) {
      DateTime curr = record.bookDate!.startDate!.toLocal();
      final List<DateTime> list = <DateTime>[curr];

      while (curr.isBefore(record.bookDate!.endDate!.toLocal())) {
        final DateTime i = curr.add(const Duration(days: 1));
        curr = i;
        list.add(curr);
      }
      return list;
    }).toList();

    final List<DateTime> dates =
        _specialDates.expand((List<DateTime> x) => x).toList();

    return dates;
  }

  void _loadRecords({DateTime? date}) {
    BlocProvider.of<BookingRecordBloc>(context).add(FetchRecordsEvent(
      category: 1,
      date: date,
      showExpired: 0,
    ));
  }

  Future<void> _cancelBooking(int recordId) async {
    try {
      await RecordRepo().cancelBook(recordId);
      showToast(
        msg: "Cancel successfully",
        backgroundColor: successColor,
      );
      _loadRecords(
        date: _selectedDate,
      );
    } catch (e) {
      showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

class DayCell extends StatelessWidget {
  const DayCell({
    Key? key,
    required this.isToday,
    required this.details,
    required this.state,
  }) : super(key: key);

  final bool isToday;
  final DateRangePickerCellDetails details;
  final BookingRecordState state;

  @override
  Widget build(BuildContext context) {
    debugPrint("isToday $isToday");
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            details.date.toLocal().day.toString(),
            style: PengoStyle.caption(context).copyWith(
              color: isToday ? primaryColor : textColor,
            ),
          ),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: isToday ? secondaryTextColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
