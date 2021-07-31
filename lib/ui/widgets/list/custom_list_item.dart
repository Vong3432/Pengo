import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  CustomListItem({
    Key? key,
    required this.leading,
    required this.content,
    this.onTap,
  }) : super(key: key);

  final Widget leading;
  final List<Widget> content;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: leading,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content),
          ),
        ],
      ),
    );
  }
}
