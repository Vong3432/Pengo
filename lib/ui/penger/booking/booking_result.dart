import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pengo/app.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/lottie_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';
import 'package:pengo/ui/widgets/list/outlined_list_tile.dart';

class BookingResultPage extends StatelessWidget {
  const BookingResultPage({Key? key, required this.bookingItem})
      : super(key: key);

  final BookingItem bookingItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Container(),
          ),
          CustomSliverBody(
            content: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    LottieBuilder.asset(
                      BOOKING_SUCCESS_LOTTIE,
                      width: 200,
                      height: 200,
                      fit: BoxFit.scaleDown,
                    ),
                    Text("Thank your for booking",
                        style: PengoStyle.navigationTitle(context)),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Convallis vestibulum augue massa sed aenean.",
                      style: PengoStyle.text(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    _buildBookedItem(context),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomButton(
                      text: const Text("Back to home"),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyHomePage()),
                            (_) => false);
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      "All booked records can be found in history tab, you can show pass by using GooCard directly without finding the pass one by one.",
                      style: textTheme(context).bodyText2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookedItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Booked",
          style: PengoStyle.caption(context),
          textAlign: TextAlign.center,
        ),
        const OutlinedListTile(
          title: "10 June 2021",
          subTitle: "10:00PM-11:00PM",
        ),
      ],
    );
  }
}
