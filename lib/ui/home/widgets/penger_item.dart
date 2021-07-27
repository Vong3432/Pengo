import 'package:flutter/material.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/ui/penger/info_view.dart';
import 'package:pengo/ui/widgets/list/custom_list_item.dart';

class PengerItem extends StatelessWidget {
  const PengerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoPage()),
          );
        },
        child: Row(
          children: <Widget>[
            CustomListItem(
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
                  style: TextStyle(
                    fontSize: textTheme(context).subtitle1!.fontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Impian Emas",
                  style: textTheme(context).subtitle2,
                ),
              ],
            ),
          ],
        ));
  }
}
