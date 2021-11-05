import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pengo/bloc/pengers/penger_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/ui/home/widgets/current_location.dart';
import 'package:pengo/ui/home/widgets/guide_card.dart';
import 'package:pengo/ui/home/widgets/home_h_listview.dart';
import 'package:pengo/ui/home/widgets/penger_item.dart';
import 'package:pengo/ui/home/widgets/quick_tap_section.dart';
import 'package:pengo/ui/home/widgets/self_booking_item.dart';
import 'package:pengo/ui/home/widgets/self_booking_list.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:pengo/ui/widgets/feedback/penger_loading_skeleton.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/stacks/h_stack.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PengerBloc _pengerBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pengerBloc = BlocProvider.of<PengerBloc>(context);
    _pengerBloc.add(const FetchPopularNearestPengers());

    GeoHelper().determinePosition();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            title: Text(
              "Home",
              style: PengoStyle.navigationTitle(context),
            ),
            actions: const <Widget>[
              CurrentLocation(),
            ],
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    // CupertinoSearchTextField(
                    //   onChanged: (String value) {
                    //     debugPrint('The text has changed to: $value');
                    //   },
                    //   onSubmitted: (String value) {
                    //     debugPrint('Submitted text: $value');
                    //   },
                    // ),
                    SelfBookingList(auth: context.watch<AuthModel>().user),
                    const QuickTapSection(),
                    _buildPopularList(context),
                    _buildNearbyList(context),
                    _buildMightInterestedList(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMightInterestedList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "You might interested",
            style: PengoStyle.header(context),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          Container(
            height: 355,
            child: HStack(
              gap: 20,
              children: <Widget>[
                GuideCard(
                  color: blueColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPopularList(BuildContext context) {
    return BlocBuilder<PengerBloc, PengerState>(
      builder: (BuildContext context, PengerState state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: SECTION_GAP_HEIGHT),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Popular",
                    style: PengoStyle.header(context),
                  ),
                  const Spacer(),
                  Text(
                    "See all",
                    style: PengoStyle.caption(context).copyWith(
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: normalShadow(Theme.of(context)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _buildPopularListContent(state),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPopularListContent(PengerState state) {
    if (state is NearestPopularPengersLoading) {
      return _buildLoading();
    }
    if (state is NearestPopularPengersLoaded) {
      return _buildPopularPengers(state);
    }
    if (state is NearestPopularPengersNotLoaded) return _buildError();
    return Container();
  }

  Text _buildError() => const Text("Something went wrong");

  ListView _buildPopularPengers(NearestPopularPengersLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.poppularPengers.length,
      itemBuilder: (BuildContext ctx, int index) {
        final Penger penger = state.poppularPengers[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: PengerItem(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                    builder: (context) => InfoPage(penger: penger)),
              );
            },
            logo: penger.logo,
            name: penger.name,
            location: penger.location?.address,
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Column(
        children: const <Widget>[
          PengerLoadingSkeleton(),
          SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          PengerLoadingSkeleton(),
          SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          PengerLoadingSkeleton(),
        ],
      );

  Widget _buildNearbyList(BuildContext context) {
    return BlocBuilder<PengerBloc, PengerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: SECTION_GAP_HEIGHT),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Nearby you",
                    style: PengoStyle.header(context),
                  ),
                  const Spacer(),
                  Text(
                    "See all",
                    style: PengoStyle.caption(context).copyWith(
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: normalShadow(Theme.of(context)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _buildNearestPengerContent(state),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildNearestPengerContent(PengerState state) {
    if (state is NearestPopularPengersLoading) return _buildLoading();
    if (state is NearestPopularPengersNotLoaded) return _buildError();
    if (state is NearestPopularPengersLoaded) {
      return _buildNearestPengers(state);
    }

    return Container();
  }

  ListView _buildNearestPengers(NearestPopularPengersLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.nearestPengers.length,
      itemBuilder: (BuildContext ctx, int index) {
        final Penger penger = state.nearestPengers[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: PengerItem(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                    builder: (context) => InfoPage(penger: penger)),
              );
            },
            logo: penger.logo,
            name: penger.name,
            location: penger.location?.address,
          ),
        );
      },
    );
  }
}
