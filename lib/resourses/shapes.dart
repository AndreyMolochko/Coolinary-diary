import 'package:flutter/material.dart';
import 'module.dart' as App;

class Shapes {
  static RoundedRectangleBorder primaryButton = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(App.Dimens.borderRadiusButton), side: BorderSide(color: App.Colors.white));

  static RoundedRectangleBorder secondaryButton = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(App.Dimens.borderRadiusButton), side: BorderSide(color: App.Colors.prussianBlue));

  static BoxDecoration whiteGradient = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 0.6, 0.85],
          colors: [App.Colors.bianca, App.Colors.gainsboro, App.Colors.white]));
}
