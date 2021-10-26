import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengo/bloc/goocard/goocard_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/logo_const.dart';
import 'package:pengo/const/shapes_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class GooCard extends StatelessWidget {
  const GooCard({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final GoocardBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaQuery(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: normalShadow(Theme.of(context)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                WAVE_SVG_PATH,
                height: double.infinity,
                color: const Color(0xFF459877),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                GOOCARD_SVG_PATH,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Current Credits",
                  style: TextStyle(color: Colors.white),
                ),
                BlocBuilder<GoocardBloc, GoocardState>(
                  builder: (BuildContext context, GoocardState state) {
                    if (state is GoocardLoading) {
                      return Skeleton(
                        style: SkeletonStyle.text,
                        textColor: whiteColor,
                        height: 20.0,
                      );
                    } else if (state is GoocardLoadSuccess) {
                      return Text(
                        "${state.goocard.creditPoints}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              PengoStyle.navigationTitle(context).fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
