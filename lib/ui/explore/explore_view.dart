import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengo/bloc/booking-items/view_booking_item_bloc.dart';
import 'package:pengo/bloc/pengers/penger_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/extensions/string_extension.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/ui/explore/cubit/filter_cubit.dart';
import 'package:pengo/ui/explore/filter_view.dart';
import 'package:pengo/ui/explore/search_view.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:pengo/ui/widgets/api/loading.dart';
import 'package:pengo/ui/widgets/api/no_result.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/extensions/double_extension.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FilterCubit _cubit = FilterCubit();
  final PengerBloc _pengerBloc = PengerBloc();
  int _tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabChanged(_tabIndex); // fetch at first load
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PengerBloc>(
      create: (BuildContext context) => _pengerBloc,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              title: Text(
                "Explore",
                style: PengoStyle.navigationTitle(context),
              ),
              actions: <Widget>[
                IconButton(
                  iconSize: 26,
                  onPressed: _openSearch,
                  icon: SvgPicture.asset(
                    SEARCH_ICON_PATH,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                IconButton(
                  iconSize: 26,
                  onPressed: _openFilter,
                  icon: SvgPicture.asset(
                    FILTER_ICON_PATH,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
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
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: <Widget>[
                  _itemsTabView(),
                  _pengersTabView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _itemsTabView() {
    debugPrint("items");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: BlocBuilder<ViewItemBloc, ViewBookingItemState>(
        builder: (BuildContext context, ViewBookingItemState state) {
          if (state is BookingItemsLoading) {
            return const LoadingWidget();
          } else if (state is BookingItemsLoaded) {
            if (state.items.isEmpty == true) {
              return const NoResultWidget();
            }
            return ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                itemCount: state.items.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: SECTION_GAP_HEIGHT);
                },
                itemBuilder: (BuildContext context, int index) {
                  final BookingItem item = state.items[index];
                  return PengerItem(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        "/booking-item",
                        arguments: {
                          "id": item.id,
                        },
                      ).then((_) => _load());
                    },
                    name: item.title,
                    logo: item.poster,
                    location: item.location,
                    trailing: item.geolocation == null
                        ? const SizedBox()
                        : FutureBuilder(
                            future: GeoHelper().distanceBetween(
                              item.geolocation!.latitude,
                              item.geolocation!.longitude,
                            ),
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<double?> snapshot,
                            ) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    SvgPicture.asset(
                                      DISTANCE_ICON_PATH,
                                      width: 16,
                                    ),
                                    Text(
                                      "${snapshot.data!.metersToKm().toStringAsFixed(1)} km",
                                      style:
                                          PengoStyle.caption(context).copyWith(
                                        color: secondaryTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            }),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }

  Container _pengersTabView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: BlocBuilder<PengerBloc, PengerState>(
        builder: (BuildContext context, PengerState state) {
          if (state is PengersLoading) {
            return const LoadingWidget();
          } else if (state is PengersLoaded) {
            if (state.pengers.isEmpty == true) {
              return const NoResultWidget();
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              itemCount: state.pengers.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: SECTION_GAP_HEIGHT);
              },
              itemBuilder: (BuildContext context, int index) {
                final Penger penger = state.pengers[index];
                return PengerItem(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(
                          CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                InfoPage(penger: penger),
                          ),
                        )
                        .then((_) => _load());
                  },
                  name: penger.name,
                  logo: penger.logo,
                  location: penger.location?.address,
                  trailing: penger.location == null
                      ? const SizedBox()
                      : FutureBuilder<double?>(
                          future: GeoHelper().distanceBetween(
                            penger.location!.geolocation.latitude,
                            penger.location!.geolocation.longitude,
                          ),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<double?> snapshot,
                          ) {
                            if (snapshot.hasData) {
                              return Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    DISTANCE_ICON_PATH,
                                    width: 16,
                                  ),
                                  Text(
                                    "${snapshot.data!.metersToKm().toStringAsFixed(1)} km",
                                    style: PengoStyle.caption(context).copyWith(
                                      color: secondaryTextColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  void _tabChanged(int index) {
    switch (index) {
      case 0:
        _cubit.filter(filterType: ExploreListFilter.items);
        break;
      case 1:
        _cubit.filter(filterType: ExploreListFilter.pengers);
        break;
      default:
    }
    _tabIndex = index;
    _load();
  }

  List<Widget> get _generateTabBar {
    return <Widget>[
      Tab(
        text: ExploreListFilter.items.toString().split(".").last.capitalize(),
      ),
      Tab(
        text: ExploreListFilter.pengers.toString().split(".").last.capitalize(),
      ),
    ];
  }

  void _openFilter() {
    Navigator.of(context, rootNavigator: true)
        .push(
          CupertinoPageRoute(
            builder: (BuildContext context) => ExploreFilterView(cubit: _cubit),
          ),
        )
        .then((_) => _load());
  }

  void _openSearch() {
    Navigator.of(context, rootNavigator: true)
        .push(
          CupertinoPageRoute(
            builder: (BuildContext context) => SearchView(cubit: _cubit),
          ),
        )
        .then((_) => _load());
  }

  void _load() {
    // debugPrint("cubit ${_cubit.state} $_tabIndex");
    if (_cubit.state.filterType == ExploreListFilter.items) {
      _tabController.animateTo(0);
      // debugPrint("fetch item");

      BlocProvider.of<ViewItemBloc>(context).add(
        FetchBookingItemsEvent(
          sortDistance:
              _cubit.state.sortBy == ExploreListSorting.distance ? 1 : null,
          sortDate: _cubit.state.sortBy == ExploreListSorting.date ? 1 : null,
          km: _cubit.state.km,
          price: _cubit.state.price,
          name: _cubit.state.name,
        ),
      );
    } else if (_cubit.state.filterType == ExploreListFilter.pengers) {
      _tabController.animateTo(1);
      // debugPrint("fetch penger");
      // fetch pengers
      _pengerBloc.add(
        FetchPengers(
          sortDistance:
              _cubit.state.sortBy == ExploreListSorting.distance ? 1 : null,
          sortDate: _cubit.state.sortBy == ExploreListSorting.date ? 1 : null,
          km: _cubit.state.km,
          name: _cubit.state.name,
        ),
      );
    }

    debugPrint("load");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}
