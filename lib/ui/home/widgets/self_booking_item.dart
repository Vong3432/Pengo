import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/extensions/double_extension.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/ui/booking-records/booking_record_detail_view.dart';

class SelfBookingItem extends StatefulWidget {
  const SelfBookingItem({
    Key? key,
    required this.record,
  }) : super(key: key);

  final BookingRecord record;

  @override
  State<SelfBookingItem> createState() => _SelfBookingItemState();
}

class _SelfBookingItemState extends State<SelfBookingItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.record.item == null) return;
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return BookingRecordDetailPage(
                id: widget.record.id,
              );
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: normalShadow(Theme.of(context)),
              borderRadius: BorderRadius.circular(25),
              color: whiteColor,
            ),
            clipBehavior: Clip.hardEdge,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    Image.network(
                      widget.record.item!.poster,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                    FutureBuilder(
                        future: GeoHelper().distanceBetween(
                          widget.record.item!.geolocation!.latitude,
                          widget.record.item!.geolocation!.longitude,
                        ),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<double?> snapshot,
                        ) {
                          if (snapshot.hasData) {
                            return Positioned.fill(
                              right: 5,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 2.0,
                                  ),
                                  child: Chip(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    backgroundColor: primaryColor,
                                    label: Text(
                                      "${snapshot.data!.metersToKm().toStringAsFixed(1)} km",
                                      style:
                                          PengoStyle.caption(context).copyWith(
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.record.item?.title ?? "",
                        style: PengoStyle.title(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.record.item?.geolocation?.name ?? "",
                              style: PengoStyle.subtitle(context).copyWith(
                                color: secondaryTextColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
