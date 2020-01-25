import 'package:flutter/material.dart';
import 'module.dart' as App;

class Shapes {
  static RoundedRectangleBorder primaryButton = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(App.Dimens.borderRadiusButton),
      side: BorderSide(color: Colors.white));
}