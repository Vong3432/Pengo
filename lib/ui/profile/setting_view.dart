import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/widgets/layout/sliver_appbar.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: Text(
              "Setting",
              style: PengoStyle.navigationTitle(context),
            ),
          ),
          CustomSliverBody(
            content: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: _buildGestureSection(context),
              )
            ],
          ),
        ],
      ),
    );
  }

  Column _buildGestureSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Gesture",
          style: PengoStyle.title(context),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: greyBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Enable shake",
                    style: PengoStyle.title2(context),
                  ),
                  Text(
                    "Shake to show pass",
                    style: PengoStyle.text(context),
                  ),
                ],
              ),
              const Spacer(),
              CupertinoSwitch(
                value: true,
                onChanged: (bool value) {
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
