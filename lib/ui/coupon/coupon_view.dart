import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/coupon/widgets/coupon.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        CustomSliverAppBar(
          title: Text(
            "Coupon",
            style: PengoStyle.navigationTitle(context),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 15),
            child: Container(
              decoration: const BoxDecoration(
                //This is for bottom border that is needed
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              width: double.infinity,
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: secondaryTextColor,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: _generateTabBar,
              ),
            ),
          ),
        ),
        const CustomSliverBody(
          content: <Widget>[
            SizedBox(
              height: SECTION_GAP_HEIGHT,
            ),
            Coupon(
              name: "20% Discount",
              pengerName: "Apple",
              date: "1 Jun - 8 Jun",
            ),
            Coupon(
              name: "CNY New Year !!!20% Discount",
              pengerName: "Apple",
              date: "8 Jun - 18 Jun",
              isRedeemed: true,
            ),
          ],
        ),
      ],
    ));
  }

  List<Widget> get _generateTabBar {
    return const <Widget>[
      Tab(
        text: "Active",
      ),
      Tab(
        text: "Redeem",
      ),
      Tab(
        text: "Expired",
      ),
    ];
  }
}
