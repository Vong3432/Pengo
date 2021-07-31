import 'package:flutter/material.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';

class CustomSliverBody extends StatelessWidget {
  const CustomSliverBody({Key? key, required this.content}) : super(key: key);

  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ...content,
          SizedBox(height: mediaQuery(context).size.height * 0.15),
        ],
      ),
    );
  }
}
