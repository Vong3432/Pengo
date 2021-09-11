import 'package:flutter/material.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/ui/penger/booking/booking_view.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';

class BookingSlotPage extends StatefulWidget {
  const BookingSlotPage({Key? key}) : super(key: key);

  @override
  _BookingSlotPageState createState() => _BookingSlotPageState();
}

class _BookingSlotPageState extends State<BookingSlotPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = mediaQuery(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
              title: Text(
            "Slots",
            style: PengoStyle.navigationTitle(context),
          )),
          CustomSliverBody(
            content: <Widget>[
              SizedBox(
                height: size.height,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        //This is for bottom border that is needed
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        indicatorColor: Colors.black,
                        tabs: _generateTabBar,
                      ),
                    ),
                    Flexible(
                      child: TabBarView(
                          controller: _tabController,
                          // list.generate should be replaced with actual tabview.
                          children: _generateTabView()),
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

  List<Tab> get _generateTabBar {
    return const <Tab>[
      Tab(
        text: "Events",
      ),
      Tab(
        text: "Appointments",
      ),
      Tab(
        text: "Items",
      ),
      Tab(
        text: "Items",
      ),
      Tab(
        text: "Items",
      ),
    ];
  }

  List<Widget> _generateTabView() {
    return List.generate(
      5,
      (int index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: CustomListItem(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => BookingView(
            //       bookingItem: bookingItemsMockData[0],
            //     ),
            //   ),
            // );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1534237710431-e2fc698436d0?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVpbGRpbmd8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
            ),
          ),
          content: <Widget>[
            Text(
              "Durian Party Night",
              style: PengoStyle.caption(context),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Impian emas",
                    style: PengoStyle.captionNormal(context),
                  ),
                ),
                Text(
                  "RM5.00",
                  style: PengoStyle.caption(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
