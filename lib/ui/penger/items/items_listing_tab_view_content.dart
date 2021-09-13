import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/bloc/booking-items/view_booking_item_bloc.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:pengo/ui/penger/booking/booking_view.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class ItemListingTabViewContent extends StatefulWidget {
  const ItemListingTabViewContent({
    Key? key,
    required this.catId,
  }) : super(key: key);

  final int catId;

  @override
  _ItemListingTabViewContentState createState() =>
      _ItemListingTabViewContentState();
}

class _ItemListingTabViewContentState extends State<ItemListingTabViewContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ViewItemBloc>(context)
        .add(FetchBookingItemsByCategoryEvent(widget.catId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewItemBloc, ViewBookingItemState>(
      builder: (BuildContext context, ViewBookingItemState state) {
        if (state is BookingItemLoading) {
          return Column(
            children: const <Widget>[
              SkeletonText(height: 25),
              SizedBox(
                width: double.infinity,
                child: SkeletonText(height: 25),
              ),
              SizedBox(
                width: double.infinity,
                child: SkeletonText(height: 25),
              ),
            ],
          );
        }
        if (state is BookingItemsLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final BookingItem item = state.items[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  BookingView(bookingItem: item)));
                        },
                        leading: Image.network(item.poster),
                        title: Text(item.title),
                        subtitle: Text(
                          item.geolocation?.name ?? '',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
