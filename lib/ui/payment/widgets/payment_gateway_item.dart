import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';

class PaymentGatewayItem extends StatelessWidget {
  const PaymentGatewayItem({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: greyBgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: <Widget>[
          Text(
            name,
            style: PengoStyle.title(context),
          )
        ],
      ),
    );
  }
}
