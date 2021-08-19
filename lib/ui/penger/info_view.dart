import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
import 'package:pengo/ui/penger/booking/booking_view.dart';
import 'package:pengo/ui/penger/review/review_view.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';
import 'package:pengo/ui/widgets/list/outlined_list_tile.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.penger}) : super(key: key);

  final Penger penger;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static late CameraPosition _kGooglePlex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.penger.location.lat, widget.penger.location.lng),
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              widget.penger.name,
              style: PengoStyle.navigationTitle(context),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(INFO_ICON_PATH, fit: BoxFit.scaleDown),
              )
            ],
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    _buildMap(),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT * 1.5,
                    ),
                    _buildActions(),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT * 1.5,
                    ),
                    _buildBookingListView(),
                    const SizedBox(
                      height: SECTION_GAP_HEIGHT * 1.5,
                    ),
                    _buildHistory(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildHistory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "History",
              style: PengoStyle.header(context),
            ),
            const Spacer(),
            GestureDetector(
              child: Text(
                "See all",
                style: PengoStyle.caption(context),
              ),
            ),
          ],
        ),
        ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: SECTION_GAP_HEIGHT,
              );
            },
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return CustomListItem(
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: primaryLightColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: index.isEven
                        ? SvgPicture.asset(
                            COUPON_ICON_PATH,
                            fit: BoxFit.scaleDown,
                          )
                        : SvgPicture.asset(TICKET_ICON_PATH,
                            fit: BoxFit.scaleDown),
                  ),
                  content: <Widget>[
                    Text(
                      index.isEven ? "Used CouponA" : "Used Ticket A",
                      style: PengoStyle.caption(context),
                    ),
                    Text(
                      "1 Jul 2021 03:00PM",
                      style: PengoStyle.captionNormal(context),
                    ),
                  ]);
            })
      ],
    );
  }

  Column _buildBookingListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              "Booking",
              style: PengoStyle.header(context),
            ),
            const Spacer(),
            GestureDetector(
              child: Text(
                "See all",
                style: PengoStyle.caption(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: SECTION_GAP_HEIGHT),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: _buildBookingItems,
          ),
        )
      ],
    );
  }

  List<Widget> get _buildBookingItems {
    return <Widget>[
      if (widget.penger.items.isEmpty)
        Text(
          'No items',
          style: PengoStyle.caption(context).copyWith(color: grayTextColor),
        )
      else
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.penger.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final BookingItem item = widget.penger.items[index];
                    return index.isEven && item.isActive == true
                        ? PengerItem(
                            name: item.title,
                            location: widget.penger.location.location,
                            logo: item.poster,
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute(
                                  builder: (context) => BookingView(
                                    bookingItem: item,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.penger.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final BookingItem item = widget.penger.items[index];
                    return index.isOdd && item.isActive
                        ? PengerItem(
                            logo: item.poster,
                            name: item.title,
                            location: widget.penger.location.location,
                          )
                        : Container();
                  },
                ),
              ),
            ),
          ],
        ),
    ];
  }

  Widget _buildActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Actions",
          style: PengoStyle.header(context),
        ),
        OutlinedListTile(
          assetName: LOCATION_ICON_PATH,
          title: "Copy location",
          subTitle: widget.penger.location.street,
          trailing: Icon(Icons.copy),
          onTap: () {
            debugPrint("Copied");
          },
        ),
        OutlinedListTile(
          assetName: REVIEW_ICON_PATH,
          title: "View review",
          subTitle: "${widget.penger.reviews.length} people reviewed",
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                builder: (context) => PengerReviewPage(
                    reviews: widget.penger.reviews, penger: widget.penger),
              ),
            );
          },
        ),
        const OutlinedListTile(
            assetName: SHARE_ICON_PATH,
            title: "Shared",
            subTitle: "Share to social media"),
      ],
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Align(
          child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}
