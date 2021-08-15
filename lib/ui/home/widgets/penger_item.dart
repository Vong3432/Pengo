import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/penger_model.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';

class PengerItem extends StatelessWidget {
  const PengerItem({Key? key, required this.name, required this.location})
      : super(key: key);

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return CustomListItem(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(
              builder: (context) => InfoPage(
                    penger: pengersMockingData[0],
                  )),
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
          name,
          style: PengoStyle.caption(context),
        ),
        Text(
          location,
          style: PengoStyle.captionNormal(context),
        ),
      ],
    );
  }
}
