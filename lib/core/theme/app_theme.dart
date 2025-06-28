import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: kBackgroundColor),
  );
}
