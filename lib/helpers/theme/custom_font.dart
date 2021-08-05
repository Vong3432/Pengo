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
        .copyWith(fontWeight: FontWeight.w600, fontSize: 16);
  }

  static TextStyle header(BuildContext context) {
    return Theme.of(context).textTheme.headline5!.copyWith();
  }

  static TextStyle navigationTitle(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith();
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

  static TextStyle captionNormal(BuildContext context) {
    return Theme.of(context).textTheme.caption!.copyWith();
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
