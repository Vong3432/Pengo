import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pengo/bloc/pengers/penger_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/models/review.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
import 'package:pengo/ui/penger/items/items_view.dart';
import 'package:pengo/ui/penger/review/review_view.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/outlined_list_tile.dart';
import 'package:pengo/ui/widgets/stacks/h_stack.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.penger}) : super(key: key);

  final Penger penger;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final PengerBloc _bloc = PengerBloc();

  static CameraPosition? _kGooglePlex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PengerBloc>(
      create: (context) => _bloc,
      child: Scaffold(
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
                  child: BlocConsumer<PengerBloc, PengerState>(
                    listener: (BuildContext context, PengerState state) {
                      if (state is PengerLoaded) {
                        _kGooglePlex = CameraPosition(
                          target: LatLng(
                            state.penger.location?.geolocation.latitude ?? 0,
                            state.penger.location?.geolocation.longitude ?? 0,
                          ),
                          zoom: 14.4746,
                        );
                      }
                    },
                    builder: (BuildContext context, PengerState state) {
                      if (state is PengerLoaded) {
                        return Column(
                          children: <Widget>[
                            _buildMap(),
                            const SizedBox(
                              height: SECTION_GAP_HEIGHT * 1.5,
                            ),
                            _buildActions(
                              state.penger.reviews ?? const <Review>[],
                            ),
                            const SizedBox(
                              height: SECTION_GAP_HEIGHT * 1.5,
                            ),
                            _buildBookingListView(
                              state.penger.items ?? const <BookingItem>[],
                            ),
                            const SizedBox(
                              height: SECTION_GAP_HEIGHT * 1.5,
                            ),
                            // _buildHistory(context),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Column _buildHistory(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: <Widget>[
  //       Row(
  //         children: <Widget>[
  //           Text(
  //             "History",
  //             style: PengoStyle.header(context),
  //           ),
  //           const Spacer(),
  //           GestureDetector(
  //             child: Text(
  //               "See all",
  //               style: PengoStyle.caption(context),
  //             ),
  //           ),
  //         ],
  //       ),
  //       ListView.separated(
  //           padding: const EdgeInsets.symmetric(vertical: 18),
  //           separatorBuilder: (BuildContext context, int index) {
  //             return const SizedBox(
  //               height: SECTION_GAP_HEIGHT,
  //             );
  //           },
  //           shrinkWrap: true,
  //           itemCount: 2,
  //           itemBuilder: (BuildContext context, int index) {
  //             return CustomListItem(
  //                 leading: Container(
  //                   width: 42,
  //                   height: 42,
  //                   decoration: BoxDecoration(
  //                     color: primaryLightColor,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   padding: const EdgeInsets.all(8),
  //                   child: index.isEven
  //                       ? SvgPicture.asset(
  //                           COUPON_ICON_PATH,
  //                           fit: BoxFit.scaleDown,
  //                         )
  //                       : SvgPicture.asset(TICKET_ICON_PATH,
  //                           fit: BoxFit.scaleDown),
  //                 ),
  //                 content: <Widget>[
  //                   Text(
  //                     index.isEven ? "Used CouponA" : "Used Ticket A",
  //                     style: PengoStyle.caption(context),
  //                   ),
  //                   Text(
  //                     "1 Jul 2021 03:00PM",
  //                     style: PengoStyle.captionNormal(context),
  //                   ),
  //                 ]);
  //           })
  //     ],
  //   );
  // }

  Column _buildBookingListView(List<BookingItem> items) {
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
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                      builder: (context) =>
                          ItemsView(pengerId: widget.penger.id)),
                );
              },
              child: Text(
                "See all",
                style: PengoStyle.caption(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: SECTION_GAP_HEIGHT),
        _buildBookingItems(items),
      ],
    );
  }

  Widget _buildBookingItems(List<BookingItem> items) {
    if (items.isEmpty) {
      return Text(
        'No items',
        style: PengoStyle.caption(context).copyWith(color: grayTextColor),
      );
    }
    return SizedBox(
      height: 50,
      child: HStack(
        gap: 5,
        children: List.generate(items.length, (index) {
          final BookingItem item = items[index];
          return PengerItem(
            width: mediaQuery(context).size.width / 2,
            name: item.title,
            location: item.location,
            logo: item.poster,
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(
                "/booking-item",
                arguments: {
                  "id": item.id,
                },
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildActions(List<Review> reviews) {
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
          subTitle: widget.penger.location?.address,
          trailing: Icon(Icons.copy),
          onTap: () {
            debugPrint("Copied");
          },
        ),
        OutlinedListTile(
          assetName: REVIEW_ICON_PATH,
          title: "View review",
          subTitle: "${reviews.length} people reviewed",
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                builder: (context) => PengerReviewPage(
                  reviews: reviews,
                  penger: widget.penger,
                ),
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
    if (_kGooglePlex == null) return Container();
    return SizedBox(
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Align(
          child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex!,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }

  void _load() {
    _bloc.add(FetchPenger(widget.penger.id));
  }
}
