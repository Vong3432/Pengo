import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';

class KmRow extends StatelessWidget {
  const KmRow({
    Key? key,
    required this.onKmTapped,
    this.km,
  }) : super(key: key);

  final ValueSetter<int> onKmTapped;
  final int? km;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "KM",
          style: PengoStyle.body(context).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: _kmList(context),
        )
      ],
    );
  }

  List<Widget> _kmList(BuildContext context) {
    List<int> kms = [5, 10, 20];
    return List.generate(
      kms.length,
      (int index) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          child: CustomButton(
            radius: 12,
            onPressed: () => onKmTapped(kms[index]),
            boxShadow: [],
            border: km == kms[index]
                ? null
                : Border.all(
                    width: 2.5,
                    color: greyBgColor,
                  ),
            fullWidth: false,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            backgroundColor: km == kms[index] ? primaryColor : whiteColor,
            text: Text(
              "${kms[index]} km",
              style: PengoStyle.caption(context).copyWith(
                fontWeight: FontWeight.bold,
                color: km == kms[index] ? whiteColor : secondaryTextColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
