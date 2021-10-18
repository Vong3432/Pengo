import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/bloc/booking-categories/booking_category_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_category_model.dart';
import 'package:pengo/ui/penger/items/items_listing_tab_view_content.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({
    Key? key,
    required this.pengerId,
  }) : super(key: key);

  final int pengerId;

  @override
  _ItemsViewState createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> with TickerProviderStateMixin {
  // late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCategoryBloc, BookingCategoryState>(
      builder: (BuildContext context, BookingCategoryState state) {
        if (state is BookingCategoriesLoading) {
          return const Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                CustomSliverAppBar(
                  title: SkeletonText(
                    height: 20,
                  ),
                ),
                CustomSliverBody(content: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: SkeletonText(height: 200),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SkeletonText(height: 200),
                  ),
                ])
              ],
            ),
          );
        }
        if (state is BookingCategoriesLoaded) {
          return DefaultTabController(
            length: state.categories.length,
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    toolbarHeight: mediaQuery(context).size.height * 0.15,
                    title: Text(
                      "Items",
                      style: PengoStyle.navigationTitle(context),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size(double.infinity, 15),
                      child: Container(
                        decoration: BoxDecoration(
                          //This is for bottom border that is needed
                          border: Border(
                              bottom: BorderSide(color: greyBgColor, width: 2)),
                        ),
                        width: double.infinity,
                        child: TabBar(
                          // controller: _tabController,
                          isScrollable: true,
                          unselectedLabelColor: secondaryTextColor,
                          labelColor: Colors.black,
                          indicatorColor: primaryColor,
                          indicatorWeight: 3,
                          tabs: state.categories
                              .map(
                                (BookingCategory cat) => Tab(
                                  text: cat.name,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: state.categories
                          .map(
                            (BookingCategory cat) => ItemListingTabViewContent(
                              catId: cat.id,
                              pengerId: widget.pengerId,
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  void _fetchCategories() {
    BlocProvider.of<BookingCategoryBloc>(context)
        .add(FetchBookingCategoriesEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _tabController.dispose();
    super.dispose();
  }
}
