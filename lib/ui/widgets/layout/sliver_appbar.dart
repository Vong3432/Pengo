import 'package:flutter/material.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.pinned,
    this.centerTitle,
    this.toolbarHeight,
    this.flexibleSpace,
    this.bottom,
  }) : super(key: key);

  final Widget title;
  final List<Widget>? actions;
  final bool? pinned;
  final bool? centerTitle;
  final double? toolbarHeight;
  final List<Widget>? flexibleSpace;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: toolbarHeight ?? mediaQuery(context).size.height * 0.1,
      backgroundColor: Colors.white,
      pinned: pinned ?? true,
      centerTitle: centerTitle ?? false,
      elevation: 0,
      title: title,
      actions: actions,
      bottom: bottom,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        background: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: flexibleSpace ?? []),
      ),
      actionsIconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(headline1: Typography.blackCupertino.headline1),
    );
  }
}
