import 'dart:ui';

import 'package:flutter/widgets.dart';

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;
double width = size.width;
double height = size.height;

double widthInventory = getOnePercent(size.width).toInt() * 28;
double heightInventory = getOnePercent(size.height).toInt() * 33;
double widthLeftColumn = getOnePercent(size.width).toInt() * 3;
double getOnePercent(double number) {
  return number * 0.01;
}
