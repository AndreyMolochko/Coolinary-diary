import 'package:flutter/cupertino.dart';
import 'package:sqflite_worker/core/application/culinary_diary.dart';

class AppProvider extends InheritedWidget {
  final CulinaryDiary application;

  AppProvider(Widget child, this.application) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
