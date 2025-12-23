import 'package:flutter/widgets.dart';

class Responsive {
  static bool isTablet(BuildContext c) => MediaQuery.of(c).size.shortestSide >= 600;
  static double width(BuildContext c) => MediaQuery.of(c).size.width;
  static double height(BuildContext c) => MediaQuery.of(c).size.height;
}
