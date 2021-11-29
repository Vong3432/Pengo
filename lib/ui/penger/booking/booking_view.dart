import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pengo/bloc/records/booking_record_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/cubit/booking/booking_form_cubit.dart';
import 'package:pengo/helpers/locale/time/time_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/helpers/toast/toast_helper.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/coupon_model.dart';
import 'package:pengo/models/system_function_model.dart';
import 'package:pengo/ui/goocard/widgets/goocard_request_modal.dart';
import 'package:pengo/ui/penger/booking/booking_result.dart';
import 'package:pengo/ui/penger/booking/widgets/book_date_modal.dart';
import 'package:pengo/ui/penger/booking/widgets/pay_modal.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingView extends StatefulWidget {
  const BookingView({
    Key? key,
    required this.bookingItem,
    required this.pengerId,
  }) : super(key: key);

  final BookingItem bookingItem;
  final int pengerId;

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  List<String> timeslots = const <String>[];
  bool _isDateModalOpened = false;
  bool _isTimeModalOpened = false;
  bool _isPayModalOpened = false;

  final BookingFormStateCubit _formStateCubit = BookingFormStateCubit();
  String? _extractTimeFromStartDt;
  String? _extractTimeFromEndDt;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.bookingItem.startFrom != null) {
      _extractTimeFromStartDt = DateFormat("HH:mm:ss")
          .format(widget.bookingItem.startFrom!.toLocal());
    }
    if (widget.bookingItem.endAt != null) {
      _extractTimeFromEndDt =
          DateFormat("HH:mm:ss").format(widget.bookingItem.endAt!.toLocal());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingFormStateCubit>(
      create: (BuildContext context) => _formStateCubit,
      child: Scaffold(
        body: BlocBuilder<BookingFormStateCubit, BookingFormState>(
          builder: (BuildContext context, BookingFormState state) {
            // Check if this category has no time limit configuration enabled
            final SystemFunction? noTimeFunc = widget
                .bookingItem.bookingCategory?.bookingOptions
                ?.firstWhereOrNull(
              (SystemFunction element) =>
                  element.name == "Fixed timeslot" && element.isActive == true,
            );

            // TODO: More configuration checking ...
            // ...

            _formStateCubit.updateFormState(
              hasPayment: widget.bookingItem.price != null &&
                  widget.bookingItem.price != 0,
              pengerId: widget.pengerId,
              bookingItemId: widget.bookingItem.id,
              hasStartDate: widget.bookingItem.startFrom != null,
              hasEndDate: widget.bookingItem.endAt != null,
              hasTime: widget.bookingItem.availableFrom != null ||
                  widget.bookingItem.availableTo != null ||
                  _extractTimeFromEndDt != null ||
                  _extractTimeFromStartDt != null,
            );

            final double _bookFormProgress =
                context.select<BookingFormStateCubit, double>(
              (BookingFormStateCubit form) => form.state.progress,
            );

            final bool _showDateTile =
                context.select<BookingFormStateCubit, bool>(
              (BookingFormStateCubit form) =>
                  form.state.hasStartDate || form.state.hasEndDate,
            );

            final bool _showTimeTile =
                context.select<BookingFormStateCubit, bool>(
              (BookingFormStateCubit form) => form.state.hasTime,
            );

            bool isOverBooked;

            if (widget.bookingItem.maxBook == null) {
              isOverBooked = false;
            } else {
              isOverBooked = _formStateCubit.checkIsOverBooked(
                widget.bookingItem.maxBook!,
                state.bookTime ?? "",
                widget.bookingItem.bookingRecords ?? [],
              );
            }

            final bool _showPaymentTile =
                context.select<BookingFormStateCubit, bool>(
                      (BookingFormStateCubit form) => form.state.hasPayment,
                    ) &&
                    _bookFormProgress == 1 &&
                    !isOverBooked;

            final bool _showNormalBookBtn =
                widget.bookingItem.isOpen != false &&
                    (widget.bookingItem.price == null ||
                        widget.bookingItem.price == 0) &&
                    _bookFormProgress == 1 &&
                    !isOverBooked;

            return CustomScrollView(
              slivers: <Widget>[
                CustomSliverAppBar(
                  toolbarHeight: mediaQuery(context).size.height * 0.15,
                  title: CustomListItem(
                    width: mediaQuery(context).size.width / 1.6,
                    leading: Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Image.network(
                        widget.bookingItem.poster,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: greyBgColor,
                          );
                        },
                      ),
                    ),
                    content: <Widget>[
                      Text(
                        widget.bookingItem.title,
                        style: TextStyle(
                          fontSize: textTheme(context).subtitle1!.fontSize,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      Text(
                        widget.bookingItem.geolocation?.name ??
                            (widget.bookingItem.location ?? ""),
                        style: textTheme(context).subtitle2,
                      ),
                      Text(
                        "RM ${widget.bookingItem.price ?? 0.0}",
                        style: textTheme(context).caption,
                      ),
                    ],
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        color: primaryColor,
                        minHeight: 6,
                        backgroundColor: greyBgColor,
                        value: context
                            .watch<BookingFormStateCubit>()
                            .state
                            .progress,
                        semanticsLabel: "Booking flow progress",
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: <Widget>[
                        Visibility(
                          visible: _showDateTile,
                          child: ListTile(
                            onTap: () => _onDateTapped(),
                            contentPadding: const EdgeInsets.all(18),
                            title: Text(
                              "Pick a date",
                              style: textTheme(context).headline5,
                            ),
                            // ewwwwww
                            subtitle: Text(
                              (state.startDate != null || state.endDate != null)
                                  ? "${state.startDate != null && state.startDate!.isNotEmpty ? state.startDate : ""}${(state.startDate != null && state.startDate!.isNotEmpty && state.endDate != null && state.endDate!.isNotEmpty) ? " to " : ""}${state.endDate != null && state.endDate!.isNotEmpty ? "${state.endDate}" : ""}"
                                  : "Choose which date you want to book",
                              style: PengoStyle.text(context),
                            ),
                            trailing: Icon(
                              _isDateModalOpened
                                  ? Icons.keyboard_arrow_down_outlined
                                  : Icons.keyboard_arrow_up_outlined,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _showDateTile,
                          child: const Divider(),
                        ),
                        Visibility(
                          visible: _showTimeTile,
                          child: ListTile(
                            onTap: () => _onTimeTapped(
                              context,
                              state,
                              noTimeFunc != null,
                            ),
                            contentPadding: const EdgeInsets.all(18),
                            title: Text(
                              "Pick a time",
                              style: textTheme(context).headline5,
                            ),
                            subtitle: Text(
                              state.bookTime ?? "Choose a time",
                              style: PengoStyle.text(context),
                            ),
                            trailing: Icon(
                              _isTimeModalOpened
                                  ? Icons.keyboard_arrow_down_outlined
                                  : Icons.keyboard_arrow_up_outlined,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: widget.bookingItem.price != null &&
                              widget.bookingItem.price != 0,
                          child: const Divider(),
                        ),
                        if (widget.bookingItem.price != null &&
                            widget.bookingItem.price != 0)
                          ListTile(
                            onTap: () => _viewCoupons(state),
                            contentPadding: const EdgeInsets.all(18),
                            title: Text(
                              "Select Coupon",
                              style: textTheme(context).headline5,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Visibility(
                                  visible: state.coupon == null,
                                  child: Text(
                                    "Use coupon",
                                    style: PengoStyle.text(context).copyWith(
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                ),
                                if (state.coupon != null)
                                  ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      "Discount percentage:",
                                      style: PengoStyle.captionNormal(context)
                                          .copyWith(
                                        color: secondaryTextColor,
                                      ),
                                    ),
                                    trailing: Text(
                                      "${state.coupon?.discountPercentage}%",
                                      style:
                                          PengoStyle.caption(context).copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (state.coupon != null)
                                  ListTile(
                                    dense: true,
                                    minVerticalPadding: 0,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      "Discount amount",
                                      style: PengoStyle.captionNormal(context)
                                          .copyWith(
                                        color: secondaryTextColor,
                                      ),
                                    ),
                                    trailing: Text(
                                      "RM ${widget.bookingItem.price! * (state.coupon!.discountPercentage / 100)}",
                                      style:
                                          PengoStyle.caption(context).copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (state.coupon != null)
                                  ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      "New price",
                                      style: PengoStyle.captionNormal(context)
                                          .copyWith(
                                        color: secondaryTextColor,
                                      ),
                                    ),
                                    trailing: Text(
                                      "RM ${widget.bookingItem.price! - (widget.bookingItem.price! * (state.coupon!.discountPercentage / 100))}",
                                      style:
                                          PengoStyle.caption(context).copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            trailing: const Icon(
                              Icons.keyboard_arrow_right_outlined,
                            ),
                          ),
                        Visibility(
                          visible: context.select<BookingFormStateCubit, bool>(
                            (BookingFormStateCubit form) => form.state.hasTime,
                          ),
                          child: const Divider(),
                        ),
                        if (_showPaymentTile)
                          ListTile(
                            onTap: () => _onPayTapped(context, _formStateCubit),
                            contentPadding: const EdgeInsets.all(18),
                            title: Text(
                              "Pay",
                              style: textTheme(context).headline5,
                            ),
                            subtitle: Text(
                              "Waiting for payment",
                              style: PengoStyle.text(context),
                            ),
                            trailing: Icon(
                              _isPayModalOpened
                                  ? Icons.keyboard_arrow_down_outlined
                                  : Icons.keyboard_arrow_up_outlined,
                            ),
                          ),
                        const Spacer(),
                        if (_showNormalBookBtn)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 28.0),
                            child: BlocConsumer<BookingRecordBloc,
                                BookingRecordState>(
                              listener: (
                                BuildContext context,
                                BookingRecordState state,
                              ) {
                                // TODO: implement listener
                                if (state is BookingRecordNotAdded) {
                                  showToast(
                                    msg: state.e.toString(),
                                    backgroundColor: dangerColor,
                                    textColor: whiteColor,
                                  );
                                } else if (state is BookingRecordAdded) {
                                  showToast(
                                    msg: state.response.msg ??
                                        "Added successfully",
                                    backgroundColor: successColor,
                                    textColor: whiteColor,
                                  );
                                  final BookingRecord returnedRecord =
                                      BookingRecord.fromJson(state.response.data
                                          as Map<String, dynamic>);
                                  _redirectToResultPage(returnedRecord);
                                }
                              },
                              builder: (
                                BuildContext context,
                                BookingRecordState recordState,
                              ) {
                                return CustomButton(
                                  isLoading: recordState is BookingRecordAdding,
                                  text: const Text("Book"),
                                  onPressed: () {
                                    _confirmBooked(state);
                                  },
                                );
                              },
                            ),
                          ),
                        Visibility(
                          visible: isOverBooked &&
                              (state.bookTime != null ||
                                  state.startDate != null),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 28.0),
                            child: Text(
                              "The booking slot is full, please change either time or date",
                              style: PengoStyle.caption(context).copyWith(
                                color: dangerColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _viewCoupons(BookingFormState state) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Material(
          child: Container(
            height: mediaQuery(context).size.height * 0.6,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Coupons",
                  style: PengoStyle.header(context),
                ),
                Text(
                  "Tap to use",
                  style: PengoStyle.smallerText(context).copyWith(
                    color: secondaryTextColor,
                  ),
                ),
                const SizedBox(height: SECTION_GAP_HEIGHT * 1.5),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.bookingItem.coupons?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final Coupon coupon = widget.bookingItem.coupons![index];
                    final bool selected = coupon.id == state.coupon?.id;
                    return ListTile(
                      onTap: () {
                        _formStateCubit.updateFormState(
                          coupon: selected ? null : coupon,
                        );
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tileColor: selected ? primaryLightColor : greyBgColor,
                      contentPadding: const EdgeInsets.all(18),
                      title: Text(
                        coupon.title,
                        style: PengoStyle.title2(context),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Visibility(
                            visible: coupon.description != null,
                            child: Text(
                              coupon.description ?? "",
                              style: PengoStyle.smallerText(context).copyWith(
                                color: secondaryTextColor,
                              ),
                            ),
                          ),
                          Text(
                            "${DateFormat("d MMM y").format(DateTime.parse(coupon.validFrom).toLocal())} - ${DateFormat("d MMM y").format(DateTime.parse(coupon.validTo).toLocal())}",
                            style: PengoStyle.smallerText(context).copyWith(
                              color: secondaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.check,
                        color: selected ? primaryColor : Colors.transparent,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _onDateTapped() {
    setState(() {
      _isDateModalOpened = true;
    });

    // current date
    DateTime _minDate = DateTime.now();

    if (widget.bookingItem.startFrom != null) {
      // check startFrom is greater than current
      // if is greater, pick the startFrom from item and set to _minDate.
      if (widget.bookingItem.startFrom!.isAfter(_minDate)) {
        _minDate = widget.bookingItem.startFrom!.toLocal();
      }
    }

    return showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: BookDateModal(
          cubit: _formStateCubit,
          minDate: _minDate.toLocal(),
          maxDate: widget.bookingItem.endAt?.toLocal(),
          selectionMode: DateRangePickerSelectionMode.range,
          closeDates: widget.bookingItem.bookingCategory?.penger?.closeDates,
        ),
      ),
    ).whenComplete(() {
      setState(() {
        _isDateModalOpened = true;
      });
    });
  }

  Future<void> _onTimeTapped(
    BuildContext context,
    BookingFormState state,
    bool isFixed,
  ) async {
    load(isFixed: isFixed);

    setState(() {
      _isTimeModalOpened = true;
    });

    return showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: const EdgeInsets.all(18),
          height: mediaQuery(context).size.height * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Available time",
                style: PengoStyle.header(context),
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: timeslots.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String currentTimeSlot = timeslots[index];
                    // Compare current user records for current item through date & time.
                    // If current endDate + currentTimeslot is found in the bookingItems.records list,
                    // set isSelected to false.
                    final bool isSelected = state.bookTime == currentTimeSlot;
                    bool isOverBooked;

                    if (widget.bookingItem.maxBook == null) {
                      isOverBooked = false;
                    } else {
                      isOverBooked = _formStateCubit.checkIsOverBooked(
                        widget.bookingItem.maxBook!,
                        currentTimeSlot,
                        widget.bookingItem.bookingRecords ?? [],
                      );
                    }

                    return Material(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        tileColor: whiteColor,
                        title: Text(
                          timeslots[index],
                          style: PengoStyle.title2(context),
                        ),
                        trailing: Chip(
                          backgroundColor: isOverBooked == true || !isSelected
                              ? greyBgColor
                              : primaryColor,
                          label: GestureDetector(
                            onTap: () {
                              _formStateCubit.updateFormState(
                                bookTime: currentTimeSlot,
                              );
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              isOverBooked == true ? "Unavailable" : "Select",
                              style: TextStyle(
                                color: isOverBooked == true || !isSelected
                                    ? secondaryTextColor
                                    : whiteColor,
                              ),
                            ),
                          ),
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

  Future<dynamic> _onPayTapped(
    BuildContext context,
    BookingFormStateCubit form,
  ) {
    setState(() {
      _isPayModalOpened = true;
    });
    return showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: const EdgeInsets.all(18),
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
                text: const Text("Pay"),
                onPressed: () async {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (BuildContext payContext) => Padding(
                      padding: EdgeInsets.only(
                        bottom: mediaQuery(context).viewInsets.bottom,
                      ),
                      child: PayModal(
                        bookingItemId: widget.bookingItem.id,
                        pengerId: widget.pengerId,
                        formState: form.state,
                      ),
                    ),
                  );
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

  Future<void> load({bool isFixed = false}) async {
    Future.delayed(Duration.zero, () {
      if ((widget.bookingItem.startFrom == null ||
              widget.bookingItem.endAt == null) &&
          (widget.bookingItem.availableFrom == null ||
              widget.bookingItem.availableTo == null)) {
        return;
      }

      if (isFixed == true) {
        final DateTime st = widget.bookingItem.startFrom!.toLocal();
        final DateTime ed = widget.bookingItem.endAt!.toLocal();

        final String timeOfDay =
            TimeOfDay(hour: st.hour, minute: st.minute).format(context);
        setState(() {
          timeslots = <String>[timeOfDay];
        });

        return;
      }

      final List<String> generatedSlots = TimeHelper.getTimeSlots(
        context,
        // will look for time from "availableFrom", otherwise look for time from "startFrom"
        start: widget.bookingItem.availableFrom != null
            ? DateTime.parse(widget.bookingItem.availableFrom!).toLocal()
            : widget.bookingItem.startFrom!,
        // will look for time from "availableTo", otherwise look for time from "endAt"
        end: widget.bookingItem.availableTo != null
            ? DateTime.parse(widget.bookingItem.availableTo!).toLocal()
            : widget.bookingItem.endAt!,
        gap: widget.bookingItem.timeGapValue,
        units: widget.bookingItem.timeGapUnits,
      );

      setState(() {
        timeslots = generatedSlots;
      });
    });
  }

  void _confirmBooked(BookingFormState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: mediaQuery(context).viewInsets,
          child: GoocardRequestModal(
            onVerifySuccess: (String pin) {
              BlocProvider.of<BookingRecordBloc>(context).add(
                BookRecordEvent(state.copyWith(pin: pin)),
              );
            },
            onVerifyFailed: () => debugPrint("Not booking"),
          ),
        );
      },
    );
  }

  Future<void> _redirectToResultPage(BookingRecord record) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => BookingResultPage(
          record: record,
        ),
      ),
      (_) => false,
    );
  }
}
