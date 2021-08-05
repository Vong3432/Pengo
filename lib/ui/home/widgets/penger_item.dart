import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';

class PengerItem extends StatelessWidget {
  const PengerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListItem(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(builder: (context) => InfoPage()),
        );
      },
      leading: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      content: <Widget>[
        Text(
          "Penger name",
          style: PengoStyle.title2(context),
        ),
        Text(
          "Impian Emas",
          style: PengoStyle.text(context),
        ),
      ],
    );
  }
}
