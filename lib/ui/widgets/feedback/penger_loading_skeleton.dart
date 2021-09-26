import 'package:flutter/material.dart';
import 'package:pengo/const/space_const.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class PengerLoadingSkeleton extends StatelessWidget {
  const PengerLoadingSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          child: const SkeletonText(height: 52),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: SkeletonText(height: 14),
                ),
                SizedBox(
                  height: SECTION_GAP_HEIGHT,
                ),
                SizedBox(
                  width: 100,
                  child: SkeletonText(height: 12),
                ),
              ],
            ),
          ),
        ),
        const Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: SizedBox(
            width: 10,
            child: SkeletonText(
              height: 18,
            ),
          ),
        ))
      ],
    );
  }
}
