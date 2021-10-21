import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/models/item_validation_model.dart';

class RequirementListItem extends StatelessWidget {
  const RequirementListItem({Key? key, required this.requirement})
      : super(key: key);

  final BookingItemValidateMsg requirement;

  @override
  Widget build(BuildContext context) {
    final Color _generatedColor = requirement.pass ? successColor : dangerColor;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _generatedColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: mediaQuery(context).size.width * 0.7,
            child: Text(
              requirement.formattedMsg,
              style: PengoStyle.caption(context).copyWith(
                color: _generatedColor,
              ),
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            requirement.pass ? VALID_ICON_PATH : INVALID_ICON_PATH,
            color: _generatedColor,
            width: 32,
          )
        ],
      ),
    );
  }
}
