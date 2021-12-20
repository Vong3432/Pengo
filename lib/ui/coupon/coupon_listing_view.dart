import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pengo/bloc/coupons/list/coupons_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/toast/toast_helper.dart';
import 'package:pengo/models/coupon_model.dart';
import 'package:pengo/ui/coupon/widgets/coupon.dart' as CouponUI;
import 'package:pengo/ui/widgets/api/loading.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabChanged(_tabIndex); // fetch at first load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        CustomSliverAppBar(
          title: Text(
            "Coupons",
            style: PengoStyle.navigationTitle(context),
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 15),
            child: Container(
              decoration: BoxDecoration(
                //This is for bottom border that is needed
                border: Border(
                  bottom: BorderSide(color: greyBgColor, width: 2),
                ),
              ),
              width: double.infinity,
              child: TabBar(
                onTap: _tabChanged,
                controller: _tabController,
                unselectedLabelColor: secondaryTextColor,
                labelColor: textColor,
                indicatorColor: primaryColor,
                indicatorWeight: 3,
                tabs: _generateTabBar,
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _activeTabBarView(),
              _redeemedTabBarView(),
              _expiredTabBarView(),
            ],
          ),
        ),
      ],
    ));
  }

  void _tabChanged(int index) {
    switch (index) {
      case 0:
        BlocProvider.of<CouponsBloc>(context)
            .add(const FetchCoupons(CouponsFilterType.active));
        break;
      case 1:
        BlocProvider.of<CouponsBloc>(context)
            .add(const FetchCoupons(CouponsFilterType.redeemed));
        break;
      case 2:
        BlocProvider.of<CouponsBloc>(context)
            .add(const FetchCoupons(CouponsFilterType.expired));
        break;
      default:
    }
    _tabIndex = index;
  }

  Container _expiredTabBarView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: BlocConsumer<CouponsBloc, CouponsState>(
          builder: (BuildContext context, CouponsState state) {
        switch (state.status) {
          case CouponsStatus.loading:
            return const LoadingWidget();
          case CouponsStatus.success:
            return _buildCouponsList(state.coupons);
          default:
            return Container();
        }
      }, listener: (BuildContext context, CouponsState state) {
        switch (state.status) {
          case CouponsStatus.failure:
            showToast(msg: "Failed to load coupons");
            break;
          default:
            break;
        }
      }),
    );
  }

  Widget _activeTabBarView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: BlocConsumer<CouponsBloc, CouponsState>(
          builder: (BuildContext context, CouponsState state) {
        switch (state.status) {
          case CouponsStatus.loading:
            return const LoadingWidget();
          case CouponsStatus.success:
            return _buildCouponsList(state.coupons);
          default:
            return Container();
        }
      }, listener: (BuildContext context, CouponsState state) {
        switch (state.status) {
          case CouponsStatus.failure:
            showToast(msg: "Failed to load coupons");
            break;
          default:
            break;
        }
      }),
    );
  }

  Container _redeemedTabBarView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: BlocConsumer<CouponsBloc, CouponsState>(
          builder: (BuildContext context, CouponsState state) {
        switch (state.status) {
          case CouponsStatus.loading:
            return const LoadingWidget();
          case CouponsStatus.success:
            return _buildCouponsList(state.coupons);
          default:
            return Container();
        }
      }, listener: (BuildContext context, CouponsState state) {
        switch (state.status) {
          case CouponsStatus.failure:
            showToast(msg: "Failed to load coupons");
            break;
          default:
            break;
        }
      }),
    );
  }

  ListView _buildCouponsList(List<Coupon> coupons) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: coupons.length,
        padding: const EdgeInsets.symmetric(vertical: 4),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: SECTION_GAP_HEIGHT,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final Coupon coupon = coupons[index];
          return CouponUI.Coupon(
            reload: () => _tabChanged(_tabIndex),
            id: coupon.id!,
            name: coupon.title,
            pengerName: coupon.createdBy?.name ?? "",
            minimumCp: coupon.requiredCreditPoints,
            date:
                '${DateFormat("d MMM y").format(DateTime.parse(coupon.validFrom).toLocal())} - ${DateFormat("d MMM y").format(DateTime.parse(coupon.validTo).toLocal())}',
          );
        });
  }

  List<Widget> get _generateTabBar {
    return const <Widget>[
      Tab(
        text: "Active",
      ),
      Tab(
        text: "Redeemed",
      ),
      Tab(
        text: "Expired",
      ),
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}
