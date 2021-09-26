import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';

class PengerItem extends StatelessWidget {
  const PengerItem(
      {Key? key,
      required this.name,
      this.location,
      this.onTap,
      this.width,
      required this.logo})
      : super(key: key);

  final String name;
  final String logo;
  final String? location;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CustomListItem(
      width: width,
      onTap: onTap ??
          () {
            // Navigator.of(context, rootNavigator: true).push(
            //   CupertinoPageRoute(
            //     builder: (context) => InfoPage(
            //       penger: pengersMockingData[0],
            //     ),
            //   ),
            // );
          },
      leading: Container(
        decoration: BoxDecoration(
          // border: Border.all(width: 2.5, color: greyBgColor),
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Image.network(
          logo,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
        ),
      ),
      content: <Widget>[
        Text(
          name,
          style: PengoStyle.title2(context),
          overflow: TextOverflow.ellipsis,
        ),
        location == null
            ? Container()
            : Text(
                location!,
                style: PengoStyle.captionNormal(context).copyWith(
                  color: secondaryTextColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
      ],
    );
  }
}
