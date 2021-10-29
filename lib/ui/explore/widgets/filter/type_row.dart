import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/extensions/string_extension.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/explore/cubit/filter_cubit.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';

class TypeRow extends StatelessWidget {
  const TypeRow({
    Key? key,
    required this.onTypeTapped,
    required this.type,
  }) : super(key: key);

  final ValueSetter<ExploreListFilter> onTypeTapped;
  final ExploreListFilter type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Type",
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
              onPressed: () => onTypeTapped(ExploreListFilter.items),
              boxShadow: [],
              border: type == ExploreListFilter.items
                  ? null
                  : Border.all(
                      width: 2.5,
                      color: greyBgColor,
                    ),
              fullWidth: false,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              backgroundColor:
                  type == ExploreListFilter.items ? primaryColor : whiteColor,
              text: Text(
                ExploreListFilter.items.toString().split(".").last.capitalize(),
                style: PengoStyle.caption(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: type == ExploreListFilter.items
                      ? whiteColor
                      : secondaryTextColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            CustomButton(
              onPressed: () => onTypeTapped(ExploreListFilter.pengers),
              fullWidth: false,
              boxShadow: [],
              radius: 12,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              border: type == ExploreListFilter.pengers
                  ? null
                  : Border.all(
                      width: 2.5,
                      color: greyBgColor,
                    ),
              backgroundColor:
                  type == ExploreListFilter.pengers ? primaryColor : whiteColor,
              text: Text(
                ExploreListFilter.pengers
                    .toString()
                    .split(".")
                    .last
                    .capitalize(),
                style: PengoStyle.caption(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: type == ExploreListFilter.pengers
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
