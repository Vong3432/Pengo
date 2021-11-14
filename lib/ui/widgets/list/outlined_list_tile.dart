import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

class OutlinedListTile extends StatelessWidget {
  const OutlinedListTile(
      {Key? key,
      this.assetName,
      this.networkUrl,
      required this.title,
      this.subTitle,
      this.trailing,
      this.onTap,
      this.leadingHeight,
      this.leadingWidth})
      : super(key: key);

  final String? assetName;
  final String? networkUrl;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final double? leadingWidth;
  final double? leadingHeight;
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
        leading: _buildLeading(),
        title: Text(
          title,
          style: PengoStyle.caption(context),
        ),
        subtitle: subTitle != null
            ? Text(
                subTitle!,
                style: PengoStyle.captionNormal(context),
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: trailing,
      ),
    );
  }

  Widget? _buildLeading() {
    if (assetName == null && networkUrl == null) return null;

    if (networkUrl != null) {
      return Image.network(
        networkUrl.toString(),
        width: leadingWidth ?? 27,
        height: leadingHeight ?? 27,
        fit: BoxFit.scaleDown,
      );
    }

    return SvgPicture.asset(
      assetName!,
      width: leadingWidth ?? 27,
      height: leadingHeight ?? 27,
      fit: BoxFit.scaleDown,
      color: primaryColor,
    );
  }
}
