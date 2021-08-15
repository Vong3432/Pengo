import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

class OutlinedListTile extends StatelessWidget {
  const OutlinedListTile({
    Key? key,
    required this.assetName,
    required this.title,
    this.subTitle,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final String assetName;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: greyBgColor, width: 2),
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: onTap,
        minLeadingWidth: 20,
        leading: SvgPicture.asset(
          assetName,
          width: 27,
          height: 27,
          fit: BoxFit.scaleDown,
        ),
        title: Text(
          title,
          style: PengoStyle.caption(context),
        ),
        subtitle: (subTitle != null && subTitle!.isNotEmpty == true)
            ? Text(
                subTitle!,
                style: PengoStyle.captionNormal(context),
                overflow: TextOverflow.ellipsis,
              )
            : Container(),
        trailing: trailing,
      ),
    );
  }
}
