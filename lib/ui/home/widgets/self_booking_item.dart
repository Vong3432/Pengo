import 'package:flutter/material.dart';

class SelfBookingItem extends StatelessWidget {
  const SelfBookingItem({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Est distance"),
                Text(
                  "32 km",
                  style: textTheme.headline4,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Cat campaign",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: textTheme.subtitle1!.fontSize,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_on,
                          size: 18,
                        ),
                        Text("Sutera, Johor", style: textTheme.caption),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
