import 'package:flutter/material.dart';

class HStack extends StatelessWidget {
  const HStack({
    Key? key,
    required this.children,
    this.gap,
  }) : super(key: key);

  final List<Widget> children;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    final double dimension = 300;

    return ListView.separated(
      shrinkWrap: true,
      clipBehavior: Clip.none,
      separatorBuilder: (BuildContext ctx, int idx) => SizedBox(
        width: gap ?? 10,
      ),
      scrollDirection: Axis.horizontal,
      physics: CustomScrollPhysics(itemDimension: dimension),
      itemCount: children.length,
      itemBuilder: (BuildContext context, int idx) {
        return children[idx];
      },
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  // ignore: sort_constructors_first
  CustomScrollPhysics({required this.itemDimension, ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollMetrics position, double portion) {
    // <--
    return (position.pixels + portion) / itemDimension;
    // -->
  }

  double _getPixels(double page, double portion) {
    // <--
    return (page * itemDimension) - portion;
    // -->
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
    double portion,
  ) {
    // <--
    double page = _getPage(position, portion);
    // -->
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    // <--
    return _getPixels(page.roundToDouble(), portion);
    // -->
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final Tolerance tolerance = this.tolerance;
    // <--
    final double portion = (position.extentInside - itemDimension) / 2;
    final double target =
        _getTargetPixels(position, tolerance, velocity, portion);
    // -->
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
