import 'package:flutter/material.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/penger/info_view.dart';

class QuickTapItem extends StatelessWidget {
  const QuickTapItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Just for navigation testing.
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => InfoPage()),
        // );
      },
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: normalShadow(Theme.of(context)),
              shape: BoxShape.circle,
            ),
            width: 65,
            height: 65,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Things 1",
              style: PengoStyle.subtitle(context),
            ),
          ),
        ],
      ),
    );
  }
}
