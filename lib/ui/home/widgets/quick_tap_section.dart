import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengo/bloc/booking-categories/booking_category_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/graphic_const.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_category_model.dart';
import 'package:pengo/ui/explore/explore_view.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class QuickTapSection extends StatefulWidget {
  const QuickTapSection({Key? key}) : super(key: key);

  @override
  State<QuickTapSection> createState() => _QuickTapSectionState();
}

class _QuickTapSectionState extends State<QuickTapSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    /*24 is for notification bar on Android*/
    final double itemHeight = mediaQuery(context).size.height * 0.277;
    final double itemWidth = mediaQuery(context).size.width / 2;

    return BlocBuilder<BookingCategoryBloc, BookingCategoryState>(
      builder: (BuildContext context, BookingCategoryState state) {
        if (state is BookingCategoriesLoading) {
          return GridView.count(
            mainAxisSpacing: SECTION_GAP_HEIGHT,
            crossAxisSpacing: SECTION_GAP_HEIGHT,
            padding: const EdgeInsets.only(bottom: 18),
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: itemWidth / itemHeight,
            shrinkWrap: true,
            crossAxisCount: 2,
            children:
                List<Widget>.generate(2, //this is the total number of cards
                    (int index) {
              return QuickTapActionItem(
                color: greyBgColor,
                isSkeleton: true,
              );
            }),
          );
        } else if (state is BookingCategoriesLoaded) {
          final int gridViewLength =
              state.categories.length < 4 ? state.categories.length + 1 : 4;
          return GridView.count(
            mainAxisSpacing: SECTION_GAP_HEIGHT,
            crossAxisSpacing: SECTION_GAP_HEIGHT,
            padding: const EdgeInsets.only(bottom: 18),
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: itemWidth / itemHeight,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List<Widget>.generate(
                gridViewLength, //this is the total number of cards
                (int index) {
              return QuickTapActionItem(
                color: _colors()[index],
                image: index == 0 ? G1_ICON_PATH : null,
                category: index == 0 ? null : state.categories[index - 1],
              );
            }),
          );
        }
        return Container();
      },
    );
    //   return Column(
    //     children: <Widget>[
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <QuickTapItem>[
    //           QuickTapItem(
    //             title: "Scan",
    //             assetName: SCAN_ICON_PATH,
    //             onTap: () {
    //               showCupertinoModalBottomSheet(
    //                   useRootNavigator: true,
    //                   context: context,
    //                   builder: (BuildContext context) {
    //                     return Container(
    //                       padding: const EdgeInsets.all(18),
    //                       height: mediaQuery(context).size.height * 0.3,
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: <Widget>[
    //                           Text(
    //                             "Use",
    //                             style: PengoStyle.header(context),
    //                           ),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                             children: <Widget>[
    //                               OptionItem(
    //                                 assetName: GOOCARD_ICON_PATH,
    //                                 title: 'Booking Pass',
    //                                 onTap: () {
    //                                   showCupertinoModalBottomSheet(
    //                                       context: context,
    //                                       builder: (context) {
    //                                         return const BookingPassView();
    //                                       });
    //                                 },
    //                               ),
    //                               const SizedBox(width: 10),
    //                               OptionItem(
    //                                   assetName: COUPON_ICON_PATH,
    //                                   title: 'Coupon',
    //                                   onTap: () {}),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     );
    //                   });
    //             },
    //           ),
    //           QuickTapItem(
    //             title: "FAQ",
    //             assetName: INFO_ICON_PATH,
    //             onTap: () {},
    //           ),
    //           QuickTapItem(
    //             title: "Coupons",
    //             assetName: COUPON_ICON_PATH,
    //             onTap: () {},
    //           ),
    //           QuickTapItem(
    //             title: "Feedback",
    //             assetName: REPORT_ICON_PATH,
    //             onTap: () {},
    //           )
    //         ],
    //       ),
    //       const Padding(
    //         padding: EdgeInsets.symmetric(vertical: 10),
    //       )
    //     ],
    //   );
  }

  void _loadCategories() {
    BlocProvider.of<BookingCategoryBloc>(context)
        .add(FetchBookingCategoriesEvent());
  }

  List<Color> _colors() {
    return [
      primaryColor,
      blueColor,
      yellowColor,
      pinkColor,
    ];
  }
}

class QuickTapActionItem extends StatelessWidget {
  const QuickTapActionItem({
    Key? key,
    required this.color,
    this.isSkeleton,
    this.image,
    this.category,
  }) : super(key: key);

  final Color color;
  final String? image;
  final BookingCategory? category;
  final bool? isSkeleton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (category != null) {
          Navigator.of(context).push(
            CupertinoPageRoute<Widget>(
              builder: (BuildContext context) {
                return InfoPage(penger: category!.penger!);
              },
            ),
          );
        } else {
          Navigator.of(context, rootNavigator: true).push(
            CupertinoPageRoute<Widget>(
              builder: (BuildContext context) => const ExploreView(),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(18),
        ),
        child: isSkeleton == true
            ? const SkeletonText(height: double.infinity)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category?.name ?? "Explore",
                    style: PengoStyle.title(context).copyWith(color: color),
                  ),
                  const Spacer(),
                  if (image != null) SvgPicture.asset(image!),
                  if (category != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Created by",
                          style: PengoStyle.captionNormal(context).copyWith(
                            color: secondaryTextColor,
                          ),
                        ),
                        Text(
                          category?.penger?.name ?? "",
                          style: PengoStyle.caption(context).copyWith(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                ],
              ),
      ),
    );
  }
}
