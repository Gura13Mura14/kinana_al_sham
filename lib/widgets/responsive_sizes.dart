import 'package:flutter/material.dart';

/// 🔹 أداة لحساب مقاسات ديناميكية حسب حجم الشاشة
class Responsive {
  final BuildContext context;
  final Size _screenSize;

  Responsive(this.context) : _screenSize = MediaQuery.of(context).size;

  double get screenWidth => _screenSize.width;
  double get screenHeight => _screenSize.height;

  double wp(double percent) => screenWidth * percent / 100;
  double hp(double percent) => screenHeight * percent / 100;

  double sp(double size) => (size * screenWidth / 400); // سيبها double
}

extension ResponsiveContext on BuildContext {
  Responsive get responsive => Responsive(this);
}


