import 'package:flutter/material.dart';

class PengoStyle {
  static TextStyle title(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontWeight: FontWeight.w600);
  }

  static TextStyle title2(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontWeight: FontWeight.w500, fontSize: 16);
  }

  static TextStyle header(BuildContext context) {
    return Theme.of(context).textTheme.headline5!.copyWith(
          fontWeight: FontWeight.w700,
        );
  }

  static TextStyle body(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: 18, fontWeight: FontWeight.normal);
  }

  static TextStyle navigationTitle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline1!
        .copyWith(fontWeight: FontWeight.w800);
  }

  static TextStyle subtitle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .subtitle1!
        .copyWith(fontWeight: FontWeight.w400, fontSize: 16);
  }

  static TextStyle text(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith();
  }

  static TextStyle smallerText(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14);
  }

  static TextStyle captionNormal(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontWeight: FontWeight.normal);
  }

  static TextStyle caption(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontWeight: FontWeight.w600);
  }

  static TextStyle subcaption(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontWeight: FontWeight.normal);
  }
}
