import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    Key? key,
    required this.record,
    this.onCancel,
    this.onReview,
  }) : super(key: key);

  final ValueSetter<int>? onCancel;
  final VoidCallback? onReview;
  final BookingRecord record;

  @override
  Widget build(BuildContext context) {
    final DateTime? startDate = record.bookDate?.startDate;
    final DateTime? endDate = record.bookDate?.endDate;

    String? fSd;
    String? fSt;
    if (startDate != null) {
      fSd = DateFormat().add_yMMMEd().format(startDate.toLocal());
      fSt = record.bookTime;
      // ?? DateFormat().add_jm().format(startDate());
    }
    String? fEd;
    String? fEt;
    if (endDate != null) {
      fEd = DateFormat().add_yMMMEd().format(endDate.toLocal());
      // fEt = DateFormat().add_jm().format(endDate());
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          "/booking-item",
          arguments: {
            "id": record.item!.id,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: normalShadow(
            Theme.of(context),
          ),
          color: whiteColor,
        ),
        padding: const EdgeInsets.all(18),
        width: mediaQuery(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingCardHeader(
              title: record.item!.title,
              poster: record.item!.poster,
              startTime: fSt,
              endTime: fEt,
              categoryName: record.item?.bookingCategory?.name ?? "",
            ),
            const SizedBox(
              height: SECTION_GAP_HEIGHT,
            ),
            BookingCardBody(
              record: record,
              startDate: startDate,
              endDate: endDate,
              fSd: fSd,
              fEd: fEd,
            ),
            const SizedBox(
              height: SECTION_GAP_HEIGHT,
            ),
            if (record.isUsed == false)
              CustomButton(
                backgroundColor: dangerColor,
                onPressed: () => _confirmDelete(context),
                text: const Text("Cancel"),
              )
            else if (record.isUsed == true &&
                record.isReviewed == false &&
                onReview != null)
              CustomButton(
                backgroundColor: secondaryTextColor,
                onPressed: () {
                  if (onReview != null) {
                    // ignore: prefer_null_aware_method_calls
                    onReview!();
                  }
                },
                text: const Text("Review"),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text(
            'Cancel booking? No refund will be given if cancel this booking'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('Yes'),
            isDestructiveAction: true,
            onPressed: () {
              // Do something destructive.
              if (onCancel != null) {
                // ignore: prefer_null_aware_method_calls
                onCancel!(record.id);
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

class BookingCardBody extends StatelessWidget {
  const BookingCardBody({
    Key? key,
    required this.record,
    this.startDate,
    this.endDate,
    this.fSd,
    this.fEd,
  }) : super(key: key);

  final BookingRecord record;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? fSd;
  final String? fEd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: startDate != null || endDate != null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(
                  Icons.timelapse,
                  color: secondaryTextColor,
                  size: 21,
                ),
                const SizedBox(width: 8),
                Visibility(
                  visible: startDate != null,
                  child: Text(
                    fSd ?? "",
                    style: PengoStyle.captionNormal(context),
                  ),
                ),
                Visibility(
                  visible: startDate != null && endDate != null,
                  child: Text(
                    " to ",
                    style: PengoStyle.captionNormal(context),
                  ),
                ),
                Visibility(
                  visible: startDate != null,
                  child: Text(
                    fEd ?? "",
                    style: PengoStyle.captionNormal(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: record.item?.geolocation?.name != null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  LOCATION_ICON_PATH,
                  color: secondaryTextColor,
                  width: 21,
                  height: 21,
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: mediaQuery(context).size.width * 0.7,
                  child: Text(
                    record.item?.geolocation?.name ?? "",
                    style: PengoStyle.captionNormal(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BookingCardHeader extends StatelessWidget {
  const BookingCardHeader(
      {Key? key,
      required this.poster,
      required this.title,
      required this.categoryName,
      this.startTime,
      this.endTime})
      : super(key: key);

  final String poster;
  final String title;
  final String categoryName;
  final String? startTime;
  final String? endTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            poster,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryName,
                style: PengoStyle.caption(context).copyWith(
                  fontSize: 12,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: PengoStyle.title(context),
              ),
              const SizedBox(
                height: 4,
              ),
              Visibility(
                visible: startTime != null || endTime != null,
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "$startTime",
                      style: PengoStyle.caption(context).copyWith(
                        color: grayTextColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
