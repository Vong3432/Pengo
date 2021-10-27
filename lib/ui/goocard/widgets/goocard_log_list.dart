import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/bloc/goocard/goocard_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/goocard_log_model.dart';
import 'package:pengo/ui/booking-records/booking_record_listing_view.dart';
import 'package:pengo/ui/coupon/coupon_listing_view.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class GooCardLogList extends StatelessWidget {
  const GooCardLogList({Key? key, required this.bloc, required this.reload})
      : super(key: key);

  final GoocardBloc bloc;
  final VoidCallback reload;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ActionButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(
                          CupertinoPageRoute(
                              builder: (context) => const CouponPage()),
                        )
                        .then((_) => reload());
                  },
                  name: "My coupons",
                  icon: COUPON_ICON_PATH,
                ),
                ActionButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(
                          CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                const BookingRecordList(),
                          ),
                        )
                        .then((_) => reload());
                  },
                  name: "My booking",
                  icon: TICKET_ICON_PATH,
                ),
                ActionButton(
                  onPressed: () {},
                  name: "Logs",
                  icon: LOG_ICON_PATH,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                HISTORY_ICON_PATH,
                width: 23,
                color: primaryColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Credits History",
                style: PengoStyle.title2(context),
              ),
              const Spacer(),
              Text(
                "See all",
                style: PengoStyle.caption(context).copyWith(
                  color: primaryColor,
                ),
              )
            ],
          ),
          const Divider(),
          BlocBuilder<GoocardBloc, GoocardState>(
            builder: (BuildContext context, GoocardState state) {
              if (state is GoocardLoading) {
                return Column(
                  children: List.generate(
                    3,
                    (int index) => const SkeletonText(height: 15),
                  ),
                );
              }
              if (state is GoocardLoadSuccess) {
                if (state.goocard.logs?.isEmpty == true) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "No record",
                      style: PengoStyle.caption(context).copyWith(
                        color: secondaryTextColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: state.goocard.logs?.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final GoocardLog log = state.goocard.logs![index];
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 10,
                        leading: Container(
                          margin: EdgeInsets.only(
                            top: mediaQuery(context).size.height * 0.01,
                          ),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: secondaryTextColor.withOpacity(0.5),
                          ),
                        ),
                        title: Text(
                          log.title,
                          style: PengoStyle.caption(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(
                          log.body ?? "",
                          style: PengoStyle.captionNormal(context).copyWith(
                            fontSize: 12,
                          ),
                        ),
                      );
                    });
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.name,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              color: primaryColor,
            ),
            const SizedBox(height: SECTION_GAP_HEIGHT / 2),
            Text(
              name,
              style: PengoStyle.captionNormal(context),
            ),
          ],
        ),
      ),
    );
  }
}
