import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/extensions/string_extension.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/explore/cubit/filter_cubit.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';

class SortRow extends StatelessWidget {
  const SortRow({
    Key? key,
    required this.onSortTapped,
    this.sort,
  }) : super(key: key);

  final ValueSetter<ExploreListSorting> onSortTapped;
  final ExploreListSorting? sort;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sort by",
          style: PengoStyle.body(context).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            CustomButton(
              radius: 12,
              onPressed: () => onSortTapped(ExploreListSorting.distance),
              boxShadow: [],
              border: sort == ExploreListSorting.distance
                  ? null
                  : Border.all(
                      width: 2.5,
                      color: greyBgColor,
                    ),
              fullWidth: false,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              backgroundColor: sort == ExploreListSorting.distance
                  ? primaryColor
                  : whiteColor,
              text: Text(
                ExploreListSorting.distance
                    .toString()
                    .split(".")
                    .last
                    .capitalize(),
                style: PengoStyle.caption(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: sort == ExploreListSorting.distance
                      ? whiteColor
                      : secondaryTextColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            CustomButton(
              onPressed: () => onSortTapped(ExploreListSorting.date),
              fullWidth: false,
              boxShadow: [],
              radius: 12,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              border: sort == ExploreListSorting.date
                  ? null
                  : Border.all(
                      width: 2.5,
                      color: greyBgColor,
                    ),
              backgroundColor:
                  sort == ExploreListSorting.date ? primaryColor : whiteColor,
              text: Text(
                ExploreListSorting.date.toString().split(".").last.capitalize(),
                style: PengoStyle.caption(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: sort == ExploreListSorting.date
                      ? whiteColor
                      : secondaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
