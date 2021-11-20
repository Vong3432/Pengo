import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/cubit/booking/booking_form_cubit.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_close_date_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:collection/collection.dart';
import 'package:pengo/extensions/date_extension.dart';

class BookDateModal extends StatefulWidget {
  const BookDateModal({
    Key? key,
    required this.cubit,
    this.minDate,
    this.maxDate,
    this.selectionMode,
    this.closeDates,
  }) : super(key: key);

  final BookingFormStateCubit cubit;
  final DateTime? minDate;
  final DateTime? maxDate;
  final List<BookingCloseDate>? closeDates;
  final DateRangePickerSelectionMode? selectionMode;

  @override
  _BookDateModalState createState() => _BookDateModalState();
}

class _BookDateModalState extends State<BookDateModal> {
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Date",
            style: textTheme(context).headline6,
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SfDateRangePicker(
              controller: _controller,
              initialSelectedRange: widget.cubit.state.range,
              showNavigationArrow: true,
              selectionMode:
                  widget.selectionMode ?? DateRangePickerSelectionMode.single,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final DateTime? rangeStartDate =
                      DateTime.tryParse(args.value.startDate.toString());
                  final DateTime? rangeEndDate =
                      DateTime.tryParse(args.value.endDate.toString());

                  final String formattedStartDate = rangeStartDate != null
                      ? DateFormat('yyyy-MM-dd').format(rangeStartDate)
                      : "";
                  final String formattedEndDate = rangeEndDate != null
                      ? DateFormat('yyyy-MM-dd').format(rangeEndDate)
                      : "";

                  widget.cubit.updateFormState(
                    startDate: formattedStartDate,
                    endDate: formattedEndDate,
                    range: args.value as PickerDateRange,
                  );
                } else if (args.value is DateTime) {
                  widget.cubit.updateFormState(
                    endDate: DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(
                        args.value.toString(),
                      ),
                    ),
                  );
                }
              },
              selectionColor: primaryColor,
              rangeSelectionColor: primaryLightColor,
              todayHighlightColor: primaryColor,
              minDate: widget.minDate?.toLocal(),
              maxDate: widget.maxDate?.toLocal(),
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: textColor,
                ),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                blackoutDates: _blackoutDates(),
                // viewHeaderStyle: DateRangePickerViewHeaderStyle(
                //   textStyle: TextStyle(color: textColor),
                // ),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                todayTextStyle: TextStyle(color: textColor),
                weekendTextStyle: TextStyle(color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime>? _blackoutDates() {
    final List<List<DateTime>>? _blackoutDates2d =
        widget.closeDates?.map((BookingCloseDate date) {
      final DateTime fD = DateTime.parse(date.from).toLocal();
      final DateTime fT = DateTime.parse(date.to).toLocal();

      DateTime curr = fD;
      final List<DateTime> list = [fD];

      while (curr.isBefore(fT)) {
        final DateTime i = curr.add(const Duration(days: 1));
        curr = i;
        list.add(curr);
      }
      return list;
    }).toList();

    final List<DateTime>? dates =
        _blackoutDates2d?.expand((List<DateTime> x) => x).toList();
    return dates;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
