import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/ui/penger/booking/booking_cubit.dart';
import 'package:pengo/ui/penger/booking/booking_result.dart';
import 'package:pengo/ui/penger/booking/booking_state.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key, required this.bookingItem}) : super(key: key);

  final BookingItem bookingItem;

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  late List<String> time;
  bool _isDateModalOpened = false;
  bool _isTimeModalOpened = false;
  bool _isPayModalOpened = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (BuildContext context, BookingState detail) {
          return CustomScrollView(
            slivers: <Widget>[
              CustomSliverAppBar(
                toolbarHeight: mediaQuery(context).size.height * 0.15,
                title: CustomListItem(
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  content: <Widget>[
                    Text(
                      widget.bookingItem.title,
                      style: TextStyle(
                        fontSize: textTheme(context).subtitle1!.fontSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.bookingItem.location,
                      style: textTheme(context).subtitle2,
                    ),
                    Text(
                      "RM ${widget.bookingItem.price}",
                      style: textTheme(context).caption,
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      color: textColor,
                      minHeight: 6,
                      backgroundColor: textColor.withOpacity(0.2),
                      value: 0.2,
                      semanticsLabel: "Booking flow progress",
                    ),
                  ),
                ),
              ),
              CustomSliverBody(content: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () => _onDateTapped(context),
                        contentPadding: EdgeInsets.all(18),
                        title: Text(
                          "1. Pick a date",
                          style: textTheme(context).headline5,
                        ),
                        subtitle: Text(
                          detail.date ?? "When you want to go?",
                          style: TextStyle(
                            fontSize: textTheme(context).subtitle2!.fontSize,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        trailing: Icon(_isDateModalOpened
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () => _onTimeTapped(context),
                        contentPadding: const EdgeInsets.all(18),
                        title: Text(
                          "2. Pick a time",
                          style: textTheme(context).headline5,
                        ),
                        subtitle: Text(
                          "Choose a time",
                          style: TextStyle(
                            fontSize: textTheme(context).subtitle2!.fontSize,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        trailing: Icon(_isTimeModalOpened
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () => _onPayTapped(context),
                        contentPadding: const EdgeInsets.all(18),
                        title: Text(
                          "3. Pay",
                          style: textTheme(context).headline5,
                        ),
                        subtitle: Text(
                          "Waiting for payment",
                          style: TextStyle(
                            fontSize: textTheme(context).subtitle2!.fontSize,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        trailing: Icon(_isPayModalOpened
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined),
                      ),
                    ],
                  ),
                ),
              ])
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> _onDateTapped(BuildContext context) {
    setState(() {
      _isDateModalOpened = true;
    });
    return showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: const EdgeInsets.all(18),
          color: textColor.shade50,
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
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    final String formattedDate = DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(args.value.toString()));
                    context.read<BookingCubit>().setDate(formattedDate);
                  },
                  selectionColor: textColor,
                  rangeSelectionColor: textColor,
                  todayHighlightColor: textColor,
                  minDate: DateTime.now(),
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        color: textColor),
                  ),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: TextStyle(color: textColor),
                    ),
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    todayTextStyle: TextStyle(color: textColor),
                    weekendTextStyle: TextStyle(color: textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      setState(() {
        _isDateModalOpened = true;
      });
    });
  }

  Future<dynamic> _onTimeTapped(BuildContext context) {
    setState(() {
      _isTimeModalOpened = true;
    });
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: const EdgeInsets.all(18),
          height: mediaQuery(context).size.height * 0.4,
          color: textColor.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Available time",
                style: textTheme(context).headline6,
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: time.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(time[index]),
                      trailing: Chip(
                        backgroundColor: textColor,
                        label: Text(
                          "Book",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      setState(() {
        _isTimeModalOpened = false;
      });
    });
  }

  Future<dynamic> _onPayTapped(BuildContext context) {
    setState(() {
      _isPayModalOpened = true;
    });
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: const EdgeInsets.all(18),
          color: textColor.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Pay with",
                style: textTheme(context).headline6,
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              CustomButton(
                text: Text("Pay"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Future.delayed(Duration(seconds: 1));
                  redirectToResultPage();
                },
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() async {
      setState(() {
        _isPayModalOpened = false;
      });
    });
  }

  Future<void> load() async {
    Future.delayed(const Duration(seconds: 3));
    setState(() {
      time = <String>[
        "10:00 PM - 11:00 PM",
        "11:00 PM - 12:00 PM",
        "12:00 PM - 13:00 PM",
        "12:00 PM - 13:00 PM",
        "12:00 PM - 13:00 PM",
        "12:00 PM - 13:00 PM",
        "12:00 PM - 13:00 PM",
        "12:00 PM - 13:00 PM",
      ];
    });
  }

  void redirectToResultPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => BookingResultPage(
          bookingItem: widget.bookingItem,
        ),
      ),
    );
  }
}
