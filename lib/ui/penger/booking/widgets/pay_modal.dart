import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pengo/bloc/records/booking_record_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/cubit/booking/booking_form_cubit.dart';
import 'package:pengo/helpers/toast/toast_helper.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/ui/goocard/widgets/goocard_request_modal.dart';
import 'package:pengo/ui/payment/payment_view.dart';
import 'package:pengo/ui/penger/booking/booking_result.dart';

class PayModal extends StatefulWidget {
  const PayModal({
    Key? key,
    required this.pengerId,
    required this.bookingItemId,
    required this.formState,
  }) : super(key: key);

  final int pengerId;
  final int bookingItemId;
  final BookingFormState formState;

  @override
  State<PayModal> createState() => _PayModalState();
}

class _PayModalState extends State<PayModal> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocListener<BookingRecordBloc, BookingRecordState>(
        listener: (BuildContext context, BookingRecordState state) {
          // TODO: implement listener
          if (state is BookingRecordAdded) {
            showToast(
              msg: "Booked success",
              backgroundColor: successColor,
            );
            final BookingRecord returnedRecord = BookingRecord.fromJson(
              state.response.data as Map<String, dynamic>,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BookingResultPage(
                  record: returnedRecord,
                ),
              ),
              (_) => false,
            );
          } else if (state is BookingRecordNotAdded) {
            showToast(
              msg: state.e.toString(),
              backgroundColor: dangerColor,
              textColor: whiteColor,
            );
          }
        },
        child: GoocardRequestModal(
          onVerifySuccess: (String pin) {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (BuildContext gatewayContext) => PaymentScreen(
                pengerId: widget.pengerId,
                bookingItemId: widget.bookingItemId,
                couponId: widget.formState.coupon?.id,
                onSuccessCallback: () {
                  debugPrint("payment ok");
                  BlocProvider.of<BookingRecordBloc>(context).add(
                    BookRecordEvent(
                      widget.formState.copyWith(pin: pin),
                    ),
                  );
                },
                onFailureCallback: () {
                  showToast(
                    msg: "Payment are not performed successfully.",
                  );
                },
              ),
            );
          },
          onVerifyFailed: () => debugPrint("Not booking"),
        ),
      ),
    );
  }
}
