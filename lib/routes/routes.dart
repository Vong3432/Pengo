import 'package:flutter/material.dart';

class Route {
  factory Route(String name, String path, Icon icon) {
    _instance.name = name;
    _instance.path = path;
    _instance.icon = icon;
    return _instance;
  }
  Route._internal();

  late String name;
  late Icon icon;
  late String path;
  static final Route _instance = Route._internal();
}
