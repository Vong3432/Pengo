import 'package:flutter/material.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/booking_record_model.dart';

class QRView extends StatelessWidget {
  const QRView({Key? key, required this.record}) : super(key: key);

  final BookingRecord record;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(18),
        height: mediaQuery(context).size.height * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  "Get scan",
                  style: PengoStyle.title(context),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
