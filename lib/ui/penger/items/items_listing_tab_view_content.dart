import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/bloc/booking-items/view_booking_item_bloc.dart';
import 'package:pengo/models/booking_item_model.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class ItemListingTabViewContent extends StatefulWidget {
  const ItemListingTabViewContent({
    Key? key,
    required this.catId,
    required this.pengerId,
  }) : super(key: key);

  final int catId;
  final int pengerId;

  @override
  _ItemListingTabViewContentState createState() =>
      _ItemListingTabViewContentState();
}

class _ItemListingTabViewContentState extends State<ItemListingTabViewContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchItems();
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
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final BookingItem item = state.items[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "/booking-item",
                            arguments: {
                              "id": item.id,
                            },
                          ).then((_) => _fetchItems());
                        },
                        leading: CachedNetworkImage(
                          imageUrl: item.poster,
                          placeholder: (BuildContext context, String url) =>
                              const SkeletonText(height: 30),
                          width: 58,
                          fit: BoxFit.cover,
                        ),
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

  void _fetchItems() {
    BlocProvider.of<ViewItemBloc>(context)
        .add(FetchBookingItemsByCategoryEvent(widget.catId));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
