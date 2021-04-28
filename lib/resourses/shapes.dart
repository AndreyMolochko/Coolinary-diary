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
  static ButtonStyle primaryButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return primaryButton;
        else return App.Shapes.secondaryButton;
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return App.Colors.porcelain;
          else return App.Colors.gainsboro;
        },
      ));
}
