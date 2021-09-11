import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.leading,
    required this.content,
    this.width,
    this.onTap,
  }) : super(key: key);

  final Widget leading;
  final List<Widget> content;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: primaryLightColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: leading,
          ),
          if (width != null)
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content),
            ),
        ],
      ),
    );
  }
}
