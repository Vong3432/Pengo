import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/main.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/ui/profile/profile_view.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';

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
            toolbarHeight: mediaQuery(context).size.height * 0.15,
            title: CustomListItem(
              leading: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              content: <Widget>[
                Text(
                  bookingItem.title,
                  style: TextStyle(
                    fontSize: textTheme(context).subtitle1!.fontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  bookingItem.location,
                  style: textTheme(context).subtitle2,
                ),
                Text(
                  "RM ${bookingItem.price}",
                  style: textTheme(context).caption,
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  color: textColor,
                  minHeight: 6,
                  backgroundColor: textColor.withOpacity(0.2),
                  value: 1,
                  semanticsLabel: "Booking flow progress",
                ),
              ),
            ),
          ),
          CustomSliverBody(
            content: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Thank your for booking",
                        style: textTheme(context).headline5),
                    const SizedBox(height: 18),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Convallis vestibulum augue massa sed aenean.",
                      style: textTheme(context).bodyText1,
                    ),
                    const Divider(),
                    _buildSocialMedia(context),
                    const Divider(),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomButton(
                      text: Text("Go to Goocard"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage()),
                        );
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

  Widget _buildSocialMedia(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Follow us on", style: textTheme(context).headline6),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: const <Icon>[
              Icon(Icons.facebook),
              Icon(Icons.ac_unit),
              Icon(Icons.wb_twilight_outlined),
            ],
          ),
        ],
      ),
    );
  }
}
