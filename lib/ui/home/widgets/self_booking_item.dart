import 'package:flutter/material.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';

class SelfBookingItem extends StatelessWidget {
  const SelfBookingItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: normalShadow(theme),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      "https://img.freepik.com/free-photo/observation-urban-building-business-steel_1127-2397.jpg?size=626&ext=jpg",
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Chip(
                            backgroundColor: textColor,
                            label: Text(
                              "32km",
                              style: TextStyle(
                                fontSize: textTheme(context).caption!.fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Cat campaign",
            style: PengoStyle.title(context),
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              Text("Sutera, Johor", style: PengoStyle.subtitle(context)),
            ],
          ),
        ],
      ),
    );
  }
}
