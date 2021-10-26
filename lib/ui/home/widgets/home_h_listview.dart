import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/widgets/stacks/h_stack.dart';

class HomeHListView extends StatefulWidget {
  const HomeHListView({
    Key? key,
    required this.children,
    required this.title,
    this.onTapSeeAll,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTapSeeAll;
  final List<Widget> children;

  @override
  _HomeHListViewState createState() => _HomeHListViewState();
}

class _HomeHListViewState extends State<HomeHListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(widget.title, style: PengoStyle.header(context)),
            const Spacer(),
            GestureDetector(
              onTap: widget.onTapSeeAll,
              child: Text(
                "See all",
                style: PengoStyle.caption(context).copyWith(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SizedBox(
            height: 250,
            child: HStack(
              gap: 20,
              children: widget.children,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
        )
      ],
    );
  }
}
