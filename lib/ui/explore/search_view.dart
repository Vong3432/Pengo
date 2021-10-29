import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/bloc/booking-items/view_booking_item_bloc.dart';
import 'package:pengo/bloc/pengers/penger_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/extensions/double_extension.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/ui/explore/cubit/filter_cubit.dart';
import 'package:pengo/ui/explore/widgets/filter/search_row.dart';
import 'package:pengo/ui/explore/widgets/filter/type_row.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:pengo/ui/widgets/api/loading.dart';
import 'package:pengo/ui/widgets/api/no_result.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final FilterCubit cubit;

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  String? _name;
  ExploreListFilter _type = ExploreListFilter.items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _name = widget.cubit.state.name;
      _type = widget.cubit.state.filterType;
    });
  }

  final ViewItemBloc _itemBloc = ViewItemBloc();
  final PengerBloc _pengerBloc = PengerBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ViewItemBloc>(
          create: (context) => _itemBloc,
        ),
        BlocProvider<PengerBloc>(
          create: (context) => _pengerBloc,
        ),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              title: Container(),
              actions: <Widget>[
                CupertinoButton(
                  onPressed: _submit,
                  child: const Text("Done"),
                ),
              ],
            ),
            CustomSliverBody(
              content: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Search",
                        style: PengoStyle.navigationTitle(context).copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      ),
                      // const SizedBox(height: SECTION_GAP_HEIGHT),
                      SearchRow(onTextFieldChanged: _nameChanged, type: _type),
                      const SizedBox(height: SECTION_GAP_HEIGHT),
                      Visibility(
                        visible: _name == null || _name?.isEmpty == true,
                        child: TypeRow(
                          type: _type,
                          onTypeTapped: _typeChanged,
                        ),
                      ),
                      if (_type == ExploreListFilter.items)
                        _buildMatchedItemList()
                      else if (_type == ExploreListFilter.pengers)
                        _buildMatchedPengerList(),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<PengerBloc, PengerState> _buildMatchedPengerList() {
    return BlocBuilder<PengerBloc, PengerState>(
      builder: (BuildContext context, PengerState state) {
        if (state is PengersLoading) {
          return const LoadingWidget();
        } else if (state is PengersLoaded) {
          if (_name == null || _name?.isEmpty == true) {
            return Container();
          }
          if (state.pengers.isEmpty == true) {
            return const NoResultWidget();
          }
          return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: state.pengers.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: SECTION_GAP_HEIGHT);
              },
              itemBuilder: (BuildContext context, int index) {
                final Penger penger = state.pengers[index];
                return PengerItem(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            InfoPage(penger: penger),
                      ),
                    );
                  },
                  name: penger.name,
                  logo: penger.logo,
                  location: penger.location?.address,
                  trailing: context.watch<GeoHelper>().currentPos == null
                      ? Container()
                      : Row(
                          children: [
                            SvgPicture.asset(
                              DISTANCE_ICON_PATH,
                              width: 16,
                            ),
                            FutureBuilder(
                                future: GeoHelper().distanceBetween(
                                  penger.location!.geolocation.latitude,
                                  penger.location!.geolocation.longitude,
                                ),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<double?> snapshot,
                                ) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      "${snapshot.data!.metersToKm().toStringAsFixed(1)} km",
                                      style:
                                          PengoStyle.caption(context).copyWith(
                                        color: secondaryTextColor,
                                        fontSize: 12,
                                      ),
                                    );
                                  }
                                  return Container();
                                }),
                          ],
                        ),
                );
              });
        }
        return Container();
      },
    );
  }

  BlocBuilder<ViewItemBloc, ViewBookingItemState> _buildMatchedItemList() {
    return BlocBuilder<ViewItemBloc, ViewBookingItemState>(
      builder: (BuildContext context, ViewBookingItemState state) {
        if (state is BookingItemsLoading) {
          return const LoadingWidget();
        } else if (state is BookingItemsLoaded) {
          if (_name == null || _name?.isEmpty == true) {
            return Container();
          }
          if (state.items.isEmpty == true) {
            return const NoResultWidget();
          }
          return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
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
                    );
                  },
                  name: item.title,
                  logo: item.poster,
                  location: item.geolocation?.name,
                  trailing: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        DISTANCE_ICON_PATH,
                        width: 16,
                      ),
                      FutureBuilder(
                          future: GeoHelper().distanceBetween(
                            item.geolocation!.latitude,
                            item.geolocation!.longitude,
                          ),
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<double?> snapshot,
                          ) {
                            if (snapshot.hasData) {
                              return Text(
                                "${snapshot.data!.metersToKm().toStringAsFixed(1)} km",
                                style: PengoStyle.caption(context).copyWith(
                                  color: secondaryTextColor,
                                  fontSize: 12,
                                ),
                              );
                            }
                            return Container();
                          }),
                    ],
                  ),
                );
              });
        }
        return Container();
      },
    );
  }

  void _nameChanged(String t) {
    setState(() {
      _name = t;
    });
    _search(t);
  }

  void _typeChanged(ExploreListFilter t) {
    setState(() {
      _type = t;
    });
  }

  void _search(String text) {
    if (_type == ExploreListFilter.items) {
      // fetch items
      _itemBloc.add(
        FetchBookingItemsEvent(
          name: text,
          limit: 5,
          searchKeywordOnly: true,
        ),
      );
    } else if (_type == ExploreListFilter.pengers) {
      // fetch pengers
      _pengerBloc.add(
        FetchPengers(
          name: text,
          limit: 5,
          searchKeywordOnly: true,
        ),
      );
    }
  }

  void _submit() {
    widget.cubit.filter(
      filterType: _type,
      name: _name,
    );
    Navigator.pop(context);
  }
}
