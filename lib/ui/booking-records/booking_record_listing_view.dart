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
                    cellDecoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.4),
                        border: Border.all(
                          color: const Color(0xFF2B732F),
                          width: 1,
                        ),
                        shape: BoxShape.circle),
                  ),
                  cellBuilder: (
                    BuildContext context,
                    DateRangePickerCellDetails details,
                  ) {
                    final DateTime today = DateTime.now();
                    final bool isToday =
                        details.date.toLocal().isSameDate(today);

                    return DayCell(
                      details: details,
                      isToday: isToday,
                      state: BlocProvider.of<BookingRecordBloc>(context).state,
                    );
                  },
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
              BlocBuilder<BookingRecordBloc, BookingRecordState>(
                builder: (BuildContext context, BookingRecordState state) {
                  if (state is BookingRecordsLoading) {
                    return const LoadingWidget();
                  } else if (state is BookingRecordsLoaded) {
                    if (state.records.isEmpty) {
                      return const Center(
                        child: Text("You haven't booked any thing yet."),
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

  void _loadRecords({DateTime? date}) {
    BlocProvider.of<BookingRecordBloc>(context).add(FetchRecordsEvent(
      category: 1,
      date: date,
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
          _buildCell(state)
        ],
      ),
    );
  }

  Widget _buildCell(BookingRecordState state) {
    if (state is BookingRecordsLoaded) {
      debugPrint("run");
      final List<BookingRecord> records =
          state.records.where((BookingRecord r) {
        bool hasRecord = false;

        if (r.bookDate == null) {
          // if this record dont have bookDate, return false directly.
          // maybe will be useless since bookDate is required.
          return hasRecord;
        } else if (r.bookDate?.startDate != null) {
          // will be executed when book records is range type

          if (r.bookDate?.endDate != null) {
            // endDate is not null
            // check if current cell is between startDate and endDate
            hasRecord = details.date.isBetweenDate(
              r.bookDate!.startDate!.toLocal(),
              r.bookDate!.endDate!.toLocal(),
            );
          } else {
            hasRecord =
                r.bookDate!.startDate!.toLocal().isSameDate(details.date);
          }
        } else {
          // will be executed when the book records is only single day
          hasRecord = r.bookDate!.endDate!.toLocal().isSameDate(details.date);
        }
        return hasRecord;
      }).toList();

      // (!) Fix if have time
      // final bool hasRecords = records.isNotEmpty;
      final bool hasRecords = false;

      if (hasRecords) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            1,
            (index) => Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryTextColor.withOpacity(
                  0.5,
                ),
              ),
            ),
          ),
        );
      }
    }

    return Container();
  }
}
