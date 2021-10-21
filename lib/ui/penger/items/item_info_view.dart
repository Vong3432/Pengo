import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/bloc/booking-items/view_booking_item_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/ui/penger/booking/booking_view.dart';
import 'package:pengo/ui/penger/items/widgets/requirement_list.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class ItemInfoView extends StatefulWidget {
  const ItemInfoView({Key? key}) : super(key: key);

  @override
  _ItemInfoViewState createState() => _ItemInfoViewState();
}

class _ItemInfoViewState extends State<ItemInfoView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      final Map args = ModalRoute.of(context)!.settings.arguments as Map;
      if (args != null) {
        final int bookingItemId = args["id"] as int;
        _load(bookingItemId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ViewItemBloc, ViewBookingItemState>(
        builder: (BuildContext context, ViewBookingItemState state) {
          if (state is BookingItemLoaded) {
            // hide book button if:
            // - user booked this item before
            // - `bookable` property status is FALSE.
            final bool showBookBtn =
                state.item.bookingRecords?.isEmpty == true &&
                    state.status.bookable;

            return CustomScrollView(
              slivers: <Widget>[
                CustomSliverAppBar(
                  centerTitle: true,
                  shadowColor: secondaryTextColor,
                  floating: true,
                  elavation: 4,
                  title: Text(
                    state.item.title,
                    style: PengoStyle.title(context).copyWith(
                      color: textColor,
                    ),
                  ),
                ),
                CustomSliverBody(
                  content: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: mediaQuery(context).size.height * 0.25,
                            decoration: const BoxDecoration(
                              // border: Border.all(width: 2.5, color: greyBgColor),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              state.item.poster,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Visibility(
                            visible: state.item.description != null,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: state.item.description != null ? 28.0 : 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Description",
                                    style: PengoStyle.title2(context).copyWith(
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    state.item.description ?? "",
                                    style: PengoStyle.text(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: SECTION_GAP_HEIGHT + 5),
                          Text(
                            "Created by",
                            style: PengoStyle.title2(context)
                                .copyWith(color: secondaryTextColor),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 22,
                            child: state.item.bookingCategory!.penger!.logo
                                    .contains("dicebear")
                                ? SvgPicture.network(
                                    state.item.bookingCategory!.penger!.logo,
                                    width: 22,
                                    height: 22,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    state.item.bookingCategory!.penger!.logo,
                                    width: 22,
                                    height: 22,
                                  ),
                          ),
                          const Divider(),
                          const SizedBox(height: SECTION_GAP_HEIGHT / 2),
                          Text(
                            "Requirements",
                            style: PengoStyle.title2(context)
                                .copyWith(color: secondaryTextColor),
                          ),
                          RequirementList(list: state.status.statusList),
                          const SizedBox(height: SECTION_GAP_HEIGHT / 2),
                          const Divider(),
                          const SizedBox(height: SECTION_GAP_HEIGHT / 2),
                          Text(
                            "Info",
                            style: PengoStyle.title2(context)
                                .copyWith(color: secondaryTextColor),
                          ),
                          const SizedBox(height: SECTION_GAP_HEIGHT / 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                MONEY_ICON_PATH,
                                width: 21,
                                color: primaryColor,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(width: SECTION_GAP_HEIGHT / 2),
                              Text(
                                "Price",
                                style: PengoStyle.text(context),
                              ),
                              const Spacer(),
                              Text(
                                "${state.item.price ?? "FREE"}",
                                style: PengoStyle.title2(context),
                              ),
                            ],
                          ),
                          const SizedBox(height: SECTION_GAP_HEIGHT / 2.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                LOCATION_ICON_PATH,
                                width: 21,
                                color: primaryColor,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(width: SECTION_GAP_HEIGHT / 2),
                              Text(
                                "Location",
                                style: PengoStyle.text(context),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: mediaQuery(context).size.width * 0.6,
                                child: Text(
                                  "${state.item.geolocation?.name}",
                                  style: PengoStyle.title2(context),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SECTION_GAP_HEIGHT * 2),
                          Visibility(
                            visible:
                                state.item.bookingRecords?.isEmpty == false,
                            child: CustomButton(
                              text: const Text("Booked"),
                              backgroundColor: secondaryTextColor,
                            ),
                          ),
                          Visibility(
                            visible: showBookBtn,
                            child: CustomButton(
                              backgroundColor:
                                  context.watch<AuthModel>().user == null
                                      ? secondaryTextColor
                                      : primaryColor,
                              onPressed: context.watch<AuthModel>().user == null
                                  ? null
                                  : () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        CupertinoPageRoute(
                                          builder: (context) => BookingView(
                                            bookingItem: state.item,
                                            pengerId: state.item
                                                .bookingCategory!.penger!.id,
                                          ),
                                        ),
                                      );
                                    },
                              text: Text(
                                context.watch<AuthModel>().user == null
                                    ? "Login to book"
                                    : "Book now",
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  void _load(int itemId) {
    BlocProvider.of<ViewItemBloc>(context).add(FetchBookingItemEvent(itemId));
  }
}
