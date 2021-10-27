import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pengo/bloc/coupons/view/coupon_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/coupon_model.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/stacks/h_stack.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class CouponInfoView extends StatefulWidget {
  const CouponInfoView({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _CouponInfoViewState createState() => _CouponInfoViewState();
}

class _CouponInfoViewState extends State<CouponInfoView> {
  final CouponBloc _couponBloc = CouponBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CouponBloc>(
      create: (context) => _couponBloc,
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: Container(),
          ),
          SliverFillRemaining(
            child: BlocBuilder<CouponBloc, CouponState>(
              builder: (BuildContext context, CouponState state) {
                switch (state.status) {
                  case CouponStatus.loading:
                    return const SkeletonText(height: 50);
                  case CouponStatus.success:
                    return Container(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.coupon!.createdBy!.name,
                            style: PengoStyle.smallerText(context).copyWith(
                              color: grayTextColor,
                            ),
                          ),
                          const SizedBox(
                            height: SECTION_GAP_HEIGHT,
                          ),
                          // Header
                          CouponInfoHeader(coupon: state.coupon!),
                          const Divider(),
                          // Coupon description & date
                          CouponInfoContent(coupon: state.coupon!),
                          const Divider(),
                          // Applicable to item listing
                          ApplicableItemList(coupon: state.coupon!),
                          const Divider(),
                          // Pengoo/Guest info
                          Expanded(
                            child: PengooInfo(
                              coupon: state.coupon!,
                              bloc: _couponBloc,
                            ),
                          ),
                        ],
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      )),
    );
  }

  void _load() {
    _couponBloc.add(FetchCoupon(widget.id));
  }
}

class CouponInfoHeader extends StatelessWidget {
  const CouponInfoHeader({
    Key? key,
    required this.coupon,
  }) : super(key: key);

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: mediaQuery(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  coupon.title,
                  style: PengoStyle.navigationTitle(context).copyWith(
                    height: 1,
                  ),
                ),
                Text(
                  "${coupon.requiredCreditPoints} cp",
                  style: PengoStyle.body(context).copyWith(
                    color: grayTextColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.hardEdge,
            child: coupon.createdBy!.logo.contains("dicebear")
                ? SvgPicture.network(
                    coupon.createdBy!.logo,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    coupon.createdBy!.logo,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
          )
        ],
      ),
    );
  }
}

class CouponInfoContent extends StatelessWidget {
  const CouponInfoContent({Key? key, required this.coupon}) : super(key: key);

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: coupon.description != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description",
                  style: PengoStyle.text(context).copyWith(
                    color: secondaryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  coupon.description!,
                  style: PengoStyle.text(context).copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          Text(
            "Date",
            style: PengoStyle.text(context).copyWith(
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${DateFormat("d MMM y").format(DateTime.parse(coupon.validFrom).toLocal())} to ${DateFormat("d MMM y").format(DateTime.parse(coupon.validTo).toLocal())}',
            style: PengoStyle.text(context).copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicableItemList extends StatelessWidget {
  const ApplicableItemList({Key? key, required this.coupon}) : super(key: key);

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 60,
        child: coupon.bookingItems == null ||
                coupon.bookingItems?.isEmpty == true
            ? Container(
                child: Text("All items of ${coupon.createdBy!.name}"),
              )
            : HStack(
                gap: 5,
                children: List.generate(coupon.bookingItems!.length, (index) {
                  final BookingItem item = coupon.bookingItems![index];
                  return PengerItem(
                    width: mediaQuery(context).size.width / 2,
                    name: item.title,
                    location: item.location,
                    logo: item.poster,
                    price: item.price ?? 0,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/booking-item",
                        arguments: {
                          "id": item.id,
                        },
                      );
                    },
                  );
                }),
              ),
      ),
    );
  }
}

class PengooInfo extends StatelessWidget {
  const PengooInfo({Key? key, required this.coupon, required this.bloc})
      : super(key: key);

  final Coupon coupon;
  final CouponBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: coupon.currentCp != null && coupon.afterCp != null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: <Widget>[
            Visibility(
              visible: coupon.isOwned == false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You have:",
                    style: PengoStyle.text(context).copyWith(
                      color: grayTextColor,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "${coupon.currentCp} cp",
                        style: PengoStyle.caption(context).copyWith(
                          color: secondaryTextColor,
                        ),
                      ),
                      Text(
                        "- ${coupon.requiredCreditPoints} cp",
                        style: PengoStyle.caption(context).copyWith(
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Visibility(
              visible: coupon.isOwned == false,
              child: Row(
                children: [
                  Text(
                    "After redeem:",
                    style: PengoStyle.text(context).copyWith(
                      color: grayTextColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${coupon.afterCp} cp",
                    style: PengoStyle.caption(context).copyWith(
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: CustomButton(
                backgroundColor:
                    coupon.isOwned == true ? secondaryTextColor : primaryColor,
                isLoading:
                    bloc.state.redeemCouponStatus == RedeemCouponStatus.loading,
                text: Text(coupon.isOwned == true ? "Redeemed" : "Redeem now"),
                onPressed: coupon.isOwned == true ? null : _redeem,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _redeem() {
    bloc.add(RedeemCoupon(coupon.id!));
  }
}
